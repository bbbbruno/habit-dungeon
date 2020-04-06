# frozen_string_literal: true

# == Schema Information
#
# Table name: admin_users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_admin_users_on_email                 (email) UNIQUE
#  index_admin_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :admin_user do
    email { 'admin@example.com' }
    password { 'password' }
    after(:build) do |admin|
      admin.avatar.attach(
        io: File.open(Rails.root.join('spec', 'factories', 'images', 'test_avatar.jpg')),
        filename: 'test_avatar.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end
