# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Challenges', type: :system do
  let(:dungeon) { create(:dungeon, user: user_a) }
  let(:user_a) { create(:user) }
  let(:user_b) { create(:user) }
  let(:login_user) { nil }

  before do
    create_enemies
    login_as login_user, scope: :user
  end

  describe '攻略一覧' do
    it 'ログインしなくても一覧が見れる' do
      visit challenges_path
      expect(page).to have_selector 'h1', text: '攻略中のダンジョン一覧'
    end
  end


  describe '攻略作成', js: true do
    context 'ログインしているとき' do
      let(:login_user) { user_a }
      context 'まだ１つも挑戦していない場合' do
        it '挑戦できる' do
          visit dungeon_path(dungeon)
          find('label', text: '挑戦する！').click
          choose 'ソロ'
          choose '易'
          page.accept_confirm do
            click_on 'はじめる！'
          end
          expect(page).to have_content 'ダンジョンの攻略をはじめました'
        end
      end

      context '既に１つ挑戦している場合' do
        before do
          create(:challenge, dungeon: dungeon, challenger: user_a)
        end
        it '挑戦できない' do
          visit dungeon_path(dungeon)
          expect(page).not_to have_selector 'label', text: '挑戦する！'
        end
      end

      context 'ダンジョンが論理削除済みの場合' do
        before do
          create(:challenge, dungeon: dungeon, challenger: user_a)
          dungeon.discard
        end
        it '挑戦できない' do
          visit dungeon_path(dungeon)
          expect(page).not_to have_selector 'label', text: '挑戦する！'
        end
      end
    end

    context 'ログインしていないとき' do
      it 'ログインページへ飛ばされる' do
        visit dungeon_path(dungeon)
        find('label', text: '挑戦する！').click
        choose 'ソロ'
        choose '易'
        page.accept_confirm do
          click_on 'はじめる！'
        end
        expect(page).to have_content 'アカウント登録もしくはログインしてください。'
      end
    end
  end

  describe '攻略詳細' do
    let(:challenge) { create(:challenge, dungeon: dungeon, challenger: user_a) }
    before do
      visit challenge_path(challenge)
    end
    it 'ログインしなくても詳細が見れる' do
      expect(page).to have_selector 'h1', text: challenge.title
    end
    it 'ダンジョン詳細が見れる' do
      click_on 'くわしく'
      expect(page).to have_selector 'h1', text: 'ダンジョン詳細'
    end
  end

  describe '攻略こうげき' do
    let(:challenge) { create(:challenge, dungeon: dungeon, challenger: user_a) }
    let(:login_user) { user_a }
    context 'まだ1日内でこうげきしていないとき' do
      it 'こうげきできる' do
        visit challenge_path(challenge)
        click_on 'こうげき！！'
        expect(page).to have_selector 'h1', text: 'ダメージを与えました！'
      end
    end
    context 'こうげき済みのとき' do
      before do
        challenge.update(attacked: true)
      end
      it 'こうげきできない' do
        visit challenge_path(challenge)
        expect(page).not_to have_button 'こうげき！！'
      end
    end
  end

  describe '攻略リタイア' do
    let(:challenge) { create(:challenge, dungeon: dungeon, challenger: user_a) }
    before do
      visit challenge_path(challenge)
    end

    context 'ログインしているとき' do
      context '挑戦者の場合', js: true do
        let(:login_user) { user_a }
        it 'リタイアできる' do
          page.accept_confirm do
            click_on 'リタイア'
          end
          expect(page).to have_content 'ダンジョン攻略をリタイアしました'
        end
      end

      context '挑戦者以外の場合' do
        let(:login_user) { user_b }
        it 'リタイアできない' do
          expect(page).not_to have_link 'リタイア'
        end
      end
    end

    context 'ログインしていないとき' do
      it 'リタイアできない' do
        expect(page).not_to have_link 'リタイア'
      end
    end
  end
end
