# == Schema Information
#
# Table name: user_auths
#
#  id          :bigint           not null, primary key
#  credentials :text
#  description :string
#  email       :string
#  image_url   :string
#  name        :string
#  nickname    :string
#  provider    :string           default(""), not null
#  raw_info    :text
#  uid         :string           default(""), not null
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_user_auths_on_uid_and_provider  (uid,provider) UNIQUE
#  index_user_auths_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :user_auth do
    user { nil }
    uid { "MyString" }
    provider { "MyString" }
    name { "MyString" }
    nickname { "MyString" }
    email { "MyString" }
    url { "MyString" }
    image_url { "MyString" }
    description { "MyString" }
    credentials { "MyText" }
    raw_info { "MyText" }
  end
end
