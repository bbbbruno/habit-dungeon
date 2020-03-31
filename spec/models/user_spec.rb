# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  discarded_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  facebook_url           :string
#  instagram_url          :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  self_introduction      :text
#  sign_in_count          :integer          default(0), not null
#  twitter_url            :string
#  unconfirmed_email      :string
#  username               :string           default(""), not null
#  youtube_url            :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_discarded_at          (discarded_at)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Challengerとして振る舞う' do
    let(:user) { create(:user) }

    describe '#challenger_name' do
      it 'ユーザー名を返す' do
        expect(user.challenger_name).to eq user.username
      end
    end

    describe '#all_challengers' do
      it '全てのユーザーを配列で返す' do
        expect(user.all_challengers).to eq [user]
      end
    end

    describe '#all_challengers_avatar' do
      it '全てのユーザーのアバターを配列で返す' do
        expect(user.all_challengers_avatar).to eq [user.avatar]
      end
    end
  end

  describe 'omniauth' do
    let(:auth) { OmniAuth::AuthHash.new(
      provider: 'google',
      uid: '123456',
      info: {
        name: 'Test User',
        email: email,
        image: 'https://via.placeholder.com/150',
      },
      credentials: { token: 'google_test' },
      extra: { raw_info: {} },
    )}
    let(:user) { create(:user, email: 'test@example.com') }
    let(:email) { 'test@example.com' }

    describe '.from_omniauth' do
      subject { User.from_omniauth(auth, current_user) }
      let(:current_user) { nil }
      context '既にgoogleと連携されてる場合' do
        before do
          create(:user_auth, :google, user: user)
        end
        it 'googleと連携しているユーザーを返す' do
          is_expected.to eq user
        end
      end

      context '既に同じメールアドレスでtwitterと連携されてる場合' do
        let(:google_auth) { UserAuth.where(provider: 'google', uid: '123456', user: user) }
        before do
          create(:user_auth, :twitter, user: user)
        end
        it 'twitterと連携しているユーザーを返す' do
          is_expected.to eq user
        end
        it 'google連携を追加する' do
          subject
          expect(google_auth).to exist
        end
      end

      context 'ログイン中に既に連携されたtwitterと違うメールアドレスでgoogle連携する場合' do
        let(:email) { 'testtest@example.com' }
        let(:current_user) { user }
        let(:google_auth) { UserAuth.where(provider: 'google', uid: '123456', user: user, email: email) }
        before do
          create(:user_auth, :twitter, user: user)
        end
        it 'ログイン中のユーザーを返す' do
          is_expected.to eq current_user
        end
        it 'google連携を追加する' do
          subject
          expect(google_auth).to exist
        end
      end

      context 'google連携で新規登録する場合' do
        let(:new_user) { User.find_by(email: '123456-google@example.com') }
        let(:google_auth) { UserAuth.where(provider: 'google', uid: '123456', user: new_user) }
        it '新しいユーザーが追加され、それを返す' do
          is_expected.to eq new_user
          expect(new_user).to be_present
        end
        it 'google連携が追加される' do
          subject
          expect(google_auth).to exist
        end
      end
    end
  end
end
