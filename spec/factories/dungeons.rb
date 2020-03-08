# frozen_string_literal: true

# == Schema Information
#
# Table name: dungeons
#
#  id          :bigint           not null, primary key
#  description :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_dungeons_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :dungeon do
    title { "MyString" }
    description { "MyText" }
    user { nil }
  end
end
