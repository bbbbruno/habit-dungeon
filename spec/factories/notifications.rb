# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id          :bigint           not null, primary key
#  kind        :integer          not null
#  message     :string           not null
#  path        :string           not null
#  read        :boolean          default("unread"), not null
#  sender_type :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  sender_id   :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_notifications_on_sender_type_and_sender_id  (sender_type,sender_id)
#  index_notifications_on_user_id                    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :notification do
    user
    for_user

    trait :for_user do
      association :sender, factory: :user
    end

    trait :for_admin do
      association :sender, factory: :admin
    end
  end
end
