# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AdminUsers', type: :system do
  let!(:admin) { create(:admin_user) }

  describe '管理画面' do
    it 'ログインできる' do
      visit new_admin_user_session_path
      fill_in 'メールアドレス', with: 'admin@example.com'
      fill_in 'パスワード', with: 'password'
      check '次回から自動的にログイン'
      click_on 'ログイン'
      expect(page).to have_content 'ログインしました。'
    end

    it 'ログアウトできる' do
      login_as admin, scope: :admin_user
      visit admin_root_path
      click_on 'ログアウト'
      expect(page).to have_content 'アカウント登録もしくはログインしてください。'
    end
  end
end
