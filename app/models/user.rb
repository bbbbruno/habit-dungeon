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
#  sign_in_count          :integer          default("0"), not null
#  twitter_url            :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :string           default(""), not null
#
# Indexes
#
#  index_users_on_discarded_at          (discarded_at)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_user_id               (user_id) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  include Discard::Model
  default_scope -> { kept }

  include Challenger

  has_one_attached :avatar
  has_many :dungeons, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :sent_notifications, as: :sender, class_name: "Notification", dependent: :destroy

  validates :user_id,
    presence: true,
    uniqueness: true,
    length: { maximum: 30 },
    format: {
      with: /\A\w+\z/,
      message: "は半角英数字と_（アンダースコア）のみが使用できます"
    }

  def active_for_authentication?
    super && !discarded?
  end

  def challenger_name
    user_id
  end

  def all_challengers
    [self]
  end

  def all_challengers_avatar
    [avatar]
  end

  def challenging?
    challenges.present?
  end
end
