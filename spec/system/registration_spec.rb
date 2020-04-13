# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registration', type: :system do
  let(:user_a) { create(:user) }

  before do
    create(:admin_user)
  end

  describe '新規登録' do
    it 'Eメールとパスワードで新規登録できる' do
      visit new_user_registration_path
      within '.form' do
        fill_in 'Eメール', with: 'test@example.com'
        fill_in 'ユーザー名', with: 'testuser'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード（確認用）', with: 'password'
      end
      expect {
        click_on 'アカウント登録'
      }.to change { ActionMailer::Base.deliveries.size }.by(1)
      expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'

      user = User.last
      token = user.confirmation_token
      visit user_confirmation_path(confirmation_token: token)
      expect(page).to have_content 'メールアドレスが確認できました。'

      within '.form' do
        fill_in 'Eメール', with: 'test@example.com'
        fill_in 'パスワード', with: 'password'
        click_on 'ログイン'
      end
      expect(page).to have_content 'ログインしました。'
    end

    describe 'Omniauth' do
      it 'Facebookで新規登録できる' do
        visit new_user_registration_path
        click_on 'Facebookでログイン'
        expect(page).to have_content 'Facebook アカウントによる認証に成功しました。'
      end

      it 'Twitterで新規登録できる' do
        visit new_user_registration_path
        click_on 'Twitterでログイン'
        expect(page).to have_content 'Twitter アカウントによる認証に成功しました。'
      end

      it 'Googleで新規登録できる' do
        visit new_user_registration_path
        click_on 'Googleでログイン'
        expect(page).to have_content 'Google アカウントによる認証に成功しました。'
      end

      context '初めてのログインのとき' do
        it 'ユーザー名を設定するように促される' do
          visit new_user_registration_path
          click_on 'Facebookでログイン'
          expect(page).to have_content 'ユーザー名を設定してください'

          logout(:user)
          visit new_user_session_path
          click_on 'Facebookでログイン'
          expect(page).not_to have_content 'ユーザー名を設定してください'
        end
      end
    end
  end

  describe 'ユーザー設定' do
    let(:user) { create(:user) }
    let(:login_user) { user }
    describe 'Omniauth' do
      before do
        login_as login_user, scope: :user
      end
      describe 'SNS連携' do
        it 'Facebookと連携できる' do
          visit edit_user_registration_path
          click_on 'Facebookで登録'
          expect(page).to have_content 'Facebookと連携しました'
        end
        it 'Twitterと連携できる' do
          visit edit_user_registration_path
          click_on 'Twitterで登録'
          expect(page).to have_content 'Twitterと連携しました'
        end
        it 'Googleと連携できる' do
          visit edit_user_registration_path
          click_on 'Googleで登録'
          expect(page).to have_content 'Googleと連携しました'
        end
      end

      describe '連携解除' do
        before do
          create(:user_auth, provider, user: user)
        end
        context 'Facebookのとき' do
          let(:provider) { :facebook }
          it '解除できる' do
            visit edit_user_registration_path
            click_on 'Facebookとの連携を解除する'
            expect(page).to have_content 'Facebookとの連携を解除しました'
          end
        end
        context 'Twitterのとき' do
          let(:provider) { :twitter }
          it '解除できる' do
            visit edit_user_registration_path
            click_on 'Twitterとの連携を解除する'
            expect(page).to have_content 'Twitterとの連携を解除しました'
          end
        end
        context 'Googleのとき' do
          let(:provider) { :google }
          it '解除できる' do
            visit edit_user_registration_path
            click_on 'Googleとの連携を解除する'
            expect(page).to have_content 'Googleとの連携を解除しました'
          end
        end
        context 'Eメールとパスワードで新規登録しておらず、SNS連携が一つしかないとき' do
          let(:login_user) { nil }
          let(:provider) { nil }
          it '解除できない' do
            visit new_user_registration_path
            click_on 'Facebookでログイン'
            click_on 'Facebookとの連携を解除する'
            expect(page).to have_content '解除前に、Eメールログインを追加または違うSNSを連携してください'
          end
        end
      end
    end
  end

  describe 'アカウント削除', js: true do
    let(:user) { create(:user) }
    it '論理削除される' do
      login_as user, scope: :user
      visit edit_user_registration_path
      page.accept_confirm do
        click_on '退会する'
      end
      expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
      expect(
        User.with_discarded.discarded.find(user.id)
      ).to be_present
    end
  end
end
