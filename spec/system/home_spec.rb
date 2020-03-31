# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home', type: :system do
  let(:dungeon) { create(:dungeon, user: user_a) }
  let(:user_a) { create(:user) }
  let(:login_user) { nil }

  before do
    create_enemies
    login_as login_user, scope: :user
  end

  context 'ログインしているとき' do
    let(:login_user) { user_a }
    context 'まだ一つも挑戦してない場合' do
      it '挑戦するよう促される' do
        visit root_path
        expect(page).to have_selector 'h1', text: '挑戦中のダンジョンがありません'
      end
    end

    context '既に挑戦しているとき' do
      let!(:challenge) { create(:challenge, dungeon: dungeon, challenger: user_a) }
      it '攻略画面が表示される' do
        visit root_path
        expect(page).to have_selector 'h1', text: challenge.title
      end
    end
  end

  context 'ログインしていないとき' do
    it 'aboutページに飛ばされる' do
      visit root_path
      expect(current_path).to eq '/about'
    end
  end
end
