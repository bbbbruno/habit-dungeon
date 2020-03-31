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
FactoryBot.define do
  factory :user do
    sequence(:email, 'a') { |n| "user_#{n}@example.com" }
    sequence(:username, 'a') { |n| "user_#{n}" }
    password { 'password' }
    confirmed_at { Time.current }

    trait :with_avatar do
      after(:build) do |user|
        user.avatar.attach(
          io: File.open(Rails.root.join('spec', 'factories', 'images', 'test_avatar.jpg')),
          filename: 'test_avatar.jpg',
          content_type: 'image/jpg'
        )
      end
    end

    factory :user_with_dungeons do
      transient do
        dungeons_count { 3 }
      end

      after(:build) do |user, evaluator|
        user.dungeons = build_list(:dungeon, evaluator.dungeons_count, user: user)
      end
    end

    factory :user_with_challenges do
      transient do
        challenges_count { 1 }
      end

      after(:build) do |user, evaluator|
        user.challenges = build_list(:challenge, evaluator.challenges_count, challenger: user)
      end
    end
  end
end
