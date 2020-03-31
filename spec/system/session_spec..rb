# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Session', type: :system do
  let(:user_a) { create(:user) }

  before do
    create(:user)
  end

  describe 'ログイン' do
    it 'Eメールとパスワードでログインできる' do
      visit new_user_session_path
      within '.form' do
        fill_in 'Eメール', with: 'user_a@example.com'
        fill_in 'パスワード', with: 'password'
        check 'ログインを記憶する'
        click_on 'ログイン'
      end
      expect(page).to have_content 'ログインしました。'
    end

    describe 'Omniauth' do
      before do
        create(:user_auth, provider, user: user_a)
      end
      context 'Facebook認証' do
        let(:provider) { :facebook }
        it 'ログインできる' do
          visit new_user_session_path
          click_on 'Facebookでログイン'
          expect(page).to have_content 'Facebook アカウントによる認証に成功しました。'
        end
        it '失敗する' do
          OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
          visit new_user_session_path
          click_on 'Facebookでログイン'
          expect(current_path).to eq page_path('about')
        end
      end

      context 'Twitter認証' do
        let(:provider) { :twitter }
        it 'ログインできる' do
          visit new_user_session_path
          click_on 'Twitterでログイン'
          expect(page).to have_content 'Twitter アカウントによる認証に成功しました。'
        end
        it '失敗する' do
          OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
          visit new_user_session_path
          click_on 'Twitterでログイン'
          expect(current_path).to eq page_path('about')
        end
      end

      context 'Google認証' do
        let(:provider) { :google }
        it 'ログインできる' do
          visit new_user_session_path
          click_on 'Googleでログイン'
          expect(page).to have_content 'Google アカウントによる認証に成功しました。'
        end
        it '失敗する' do
          OmniAuth.config.mock_auth[:google] = :invalid_credentials
          visit new_user_session_path
          click_on 'Googleでログイン'
          expect(current_path).to eq page_path('about')
        end
      end
    end

    it 'ログアウトできる' do
      login_as user_a, scope: :user
      visit root_path
      find('.toggle-menu._user').click
      click_on 'ログアウト'
      expect(page).to have_content 'ログアウトしました。'
    end
  end
end
