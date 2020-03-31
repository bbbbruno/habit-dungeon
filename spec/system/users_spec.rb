# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { create(:user) }

  describe 'ユーザー一覧' do
    it 'ログインしなくても一覧が見れる' do
      visit users_path
      expect(page).to have_selector 'h1', text: 'プレイヤー一覧'
    end
  end

  describe 'ユーザー詳細' do
    it 'ログインしなくても詳細が見れる' do
      visit user_path(user)
      expect(page).to have_selector 'h1', text: 'マイページ'
      expect(page).to have_selector 'h2', text: user.username
    end
  end
end
