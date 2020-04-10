# frozen_string_literal: true

# == Schema Information
#
# Table name: challenges
#
#  id              :bigint           not null, primary key
#  attacked        :boolean          default(FALSE), not null
#  challenger_type :string           not null
#  clear           :boolean          default(FALSE), not null
#  difficulty      :string           default("easy"), not null
#  life            :integer          default(3), not null
#  over_days       :integer          default(0), not null
#  progress        :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  challenger_id   :bigint           not null
#  dungeon_id      :bigint           not null
#  enemy_id        :bigint           not null
#
# Indexes
#
#  index_challenges_on_challenger_type_and_challenger_id  (challenger_type,challenger_id)
#  index_challenges_on_dungeon_id                         (dungeon_id)
#  index_challenges_on_enemy_id                           (enemy_id)
#
# Foreign Keys
#
#  fk_rails_...  (dungeon_id => dungeons.id)
#  fk_rails_...  (enemy_id => enemies.id)
#
require 'rails_helper'

RSpec.describe Challenge, type: :model do
  let(:challenge) { create :challenge, progress: progress }
  let(:progress) { 0 }

  before do
    create_enemies
  end

  describe 'challengeを作成' do
    context '難易度が「易」のとき' do
      it '初期ライフに３が設定される' do
        expect(challenge.life).to eq 3
      end
    end
    it 'レベル１のモンスターが設定される' do
      expect(challenge.enemy.level).to eq 1
    end
  end

  describe '#current_level' do
    # Lv1開始 0日目, Lv2開始 11日目, Lv3開始 22日, Lv4開始 33日目,
    # lv5開始 44日目, lv6開始 55日目, Clear 66日目
    subject { challenge.current_level }

    context '継続日数１１日目のとき' do
      let(:progress) { 11 }
      it { is_expected.to eq 2 }
    end

    context '継続日数２８日目のとき' do
      let(:progress) { 28 }
      it { is_expected.to eq 3 }
    end

    context '継続日数が最終レベルを超えたとき' do
      let(:progress) { 70 }
      let(:last_level) { challenge.levels.last.number }
      it { is_expected.to eq last_level }
    end
  end

  describe '#enemy_life' do
    # Lv1開始 0日目, Lv2開始 11日目, Lv3開始 22日, Lv4開始 33日目,
    # lv5開始 44日目, lv6開始 55日目, Clear 66日目
    subject { challenge.enemy_life }

    context '継続日数８日目のとき' do
      let(:progress) { 8 }
      it { is_expected.to eq 3 }
    end

    context '継続日数３１日目のとき' do
      let(:progress) { 31 }
      it { is_expected.to eq 2 }
    end

    context '継続日数が最終レベルを超えたとき' do
      let(:progress) { 75 }
      it { is_expected.to eq 0 }
    end
  end

  describe '#rankup' do
    # Lv1開始 0日目, Lv2開始 11日目, Lv3開始 22日, Lv4開始 33日目,
    # lv5開始 44日目, lv6開始 55日目, Clear 66日目
    subject { challenge.rank_up }

    context '継続日数がレベル２に達したとき' do
      let(:progress) { 11 }
      it { is_expected_block.to change { challenge.enemy.level }.by(1) }
    end

    context '次のレベルがないとき' do
      let(:progress) { 66 }
      it { is_expected_block.not_to change { challenge.enemy.level } }
    end
  end

  describe '#rankdown' do
    subject { challenge.rank_down }

    describe 'レベルが下がる' do
      context 'レベル１のとき' do
        it { is_expected_block.not_to change { challenge.enemy.level } }
      end

      context 'レベルが２以上のとき' do
        let(:challenge) { create(:challenge, :level2) }
        it { is_expected_block.to change { challenge.enemy.level }.by(-1) }
      end

      context '最終レベルを超えているとき' do
        let(:challenge) { create(:challenge, :over_level) }
        it { is_expected_block.not_to change { challenge.enemy.level } }
      end
    end

    describe 'ライフが全回復する' do
      before do
        challenge.life = 0
      end
      it { is_expected_block.to change { challenge.life }.from(0).to(3) }
    end
  end

  describe '#deal_damage' do
    subject { challenge.deal_damage }
    before do
      create(:admin_user)
    end

    describe 'ダメージを与える' do
      it { is_expected_block.to change { challenge.life }.by(-1) }
    end

    describe 'ダメージを受けたユーザーに「ダメージを受けました」通知が飛ぶか' do
      let(:notifications) { challenge.challenger.notifications.where(kind: :challenge_damaged) }
      context 'ダメージ後のライフが１以上のとき' do
        it { is_expected_block.to change { notifications.count }.by(1) }
      end

      context 'ダメージ後のライフが０のとき' do
        before do
          challenge.life = 1
        end
        it { is_expected_block.not_to change { notifications.count } }
      end
    end
  end

  describe 'ランクアップ、ランクダウン' do
    # Lv1開始 0日目, Lv2開始 11日目, Lv3開始 22日, Lv4開始 33日目,
    # lv5開始 44日目, lv6開始 55日目, Clear 66日目
    before do
      create(:admin_user)
    end

    context 'こうげき済みかつ次のレベルの開始日に達したとき' do
      subject { challenge.update(attacked: true, progress: 11) }
      before do
        challenge.life = 2
      end
      it 'ランクアップする' do
        expect { subject }.to change { challenge.enemy.level }.by(1)
      end
      it 'ライフが１つ回復する' do
        expect { subject }.to change { challenge.life }.by(1)
      end
    end

    context 'こうげき済みだがレベルの開始日にいないとき' do
      subject { challenge.update(attacked: true, progress: 15) }
      it 'ランクアップしない' do
        is_expected_block.not_to change { challenge.enemy.level }
      end
    end

    context 'ダメージを受けてライフが０になったとき' do
      subject { challenge.deal_damage }
      let(:challenge) { create(:challenge, :level2) }
      let(:notifications) { challenge.challenger.notifications.where(kind: :challenge_rank_downed) }
      before do
        challenge.life = 1
      end
      it 'ランクダウンする' do
        is_expected_block.to change { challenge.enemy.level }.by(-1)
      end
      it '「ランクダウンしました」通知が飛ぶ' do
        is_expected_block.to change { notifications.count }.by(1)
      end
    end

    context '最終レベルを超えているときにダメージを受けたとき' do
      subject { challenge.deal_damage }
      let(:challenge) { create(:challenge, :over_level) }
      it '何も変わらない' do
        is_expected_block.not_to change { challenge }
      end
    end
  end
end
