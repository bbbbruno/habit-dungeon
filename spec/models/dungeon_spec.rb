# frozen_string_literal: true

# == Schema Information
#
# Table name: dungeons
#
#  id           :bigint           not null, primary key
#  description  :text
#  discarded_at :datetime
#  title        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_dungeons_on_discarded_at  (discarded_at)
#  index_dungeons_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Dungeon, type: :model do
  let(:dungeon) { create(:dungeon) }

  before do
    create_enemies
  end

  describe '#all_uniq_challengers' do
    subject { dungeon.all_uniq_challengers }
    let(:uniq_users) { Challenge.where(challenger_type: 'User', dungeon: dungeon).map(&:challenger).uniq }
    before do
      per_user = 1
      5.times do
        user = create(:user)
        create_list(:challenge, per_user, :for_user, challenger: user, dungeon: dungeon)
      end
    end
    it { is_expected.to match_array uniq_users }
  end

  describe 'Discard' do
    subject { dungeon.discard }
    let!(:dungeon) { create(:dungeon) }
    it '論理削除削除された後は、紐づいているchallengeがなければそのままdestroyする' do
      is_expected_block.to change { Dungeon.with_discarded.count }.by(-1)
    end
  end
end
