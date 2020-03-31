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

require 'open-uri'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable, :omniauthable,
         omniauth_providers: %i[facebook twitter google]
  has_many :user_auths, dependent: :destroy

  include Discard::Model
  default_scope -> { kept }
  def active_for_authentication?
    super && !discarded?
  end

  include Challenger

  has_one_attached :avatar, dependent: :destroy
  has_one_attached :header, dependent: :destroy
  has_many :dungeons
  has_many :notifications, dependent: :destroy
  has_many :sent_notifications, as: :sender, class_name: 'Notification', dependent: :destroy

  validates :username,
    presence: true,
    uniqueness: true,
    length: { maximum: 30 },
    format: {
      with: /\A\w+\z/,
      message: 'は半角英数字と_（アンダースコア）のみが使用できます'
    }

  DEFAULT_MAX_CHALLENGE = 1

  def self.from_omniauth(auth, current_user)
    # returning users
    user_auth = UserAuth.find_by(provider: auth.provider, uid: auth.uid)
    return user_auth.user if user_auth

    email = auth.info.email

    # match existing users
    existing_user = find_for_database_authentication(email: email.downcase)
    if existing_user
      oauth = existing_user.add_oauth_authorization(auth)
      existing_user.update_attributes_only_if_blank(username: oauth.nickname, name: oauth.name, self_introduction: oauth.description)
      oauth.save
      return existing_user
    end

    # already signed in once
    if current_user
      oauth = current_user.add_oauth_authorization(auth)
      current_user.update_attributes_only_if_blank(username: oauth.nickname, name: oauth.name, self_introduction: oauth.description)
      oauth.save
      return current_user
    end

    create_new_user_from_oauth(auth, email)
  end

  def add_oauth_authorization(data)
    case data.provider
    when 'facebook'
      nickname = SecureRandom.alphanumeric(10)
      url = ''
      update(facebook_url: url)
    when 'twitter'
      nickname = data.info.nickname
      url = data.info.urls.Twitter
      update(twitter_url: url)
    when 'google'
      nickname = data.info.email.split('@').first.tr('.', '_')
      url = ''
    end
    user_auths.build({
      provider: data.provider,
      uid: data.uid,
      email: data.info.email,
      name: data.info.name,
      nickname: nickname,
      description: data.info.description,
      url: url,
      image_url: data.info.image,
      credentials: data.credentials.to_json,
      raw_info: data.extra.raw_info.to_json,
    })
  end

  def update_attributes_only_if_blank(attributes)
    attributes.each { |k, v| attributes.delete(k) unless read_attribute(k).blank? }
    update(attributes)
  end

  def challenger_name
    username
  end

  def all_challengers
    [self]
  end

  def all_challengers_avatar
    [avatar]
  end

  private
    def self.create_new_user_from_oauth(auth, email)
      user = User.new({
        email: User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
      })
      oauth = user.add_oauth_authorization(auth)
      user.username = oauth.nickname
      user.self_introduction = oauth.description
      user.avatar.attach(io: open(oauth.image_url), filename: "#{user.username}_avatar.jpg", content_type: 'image/jpg')
      user.skip_confirmation!
      user.save
      user
    end

    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end
end
