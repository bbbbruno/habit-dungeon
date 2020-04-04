# == Schema Information
#
# Table name: news
#
#  id         :bigint           not null, primary key
#  content    :text
#  status     :boolean          default(FALSE), not null
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :news do
    title { "MyString" }
    content { "MyText" }
    index { "MyString" }
    show { "MyString" }
  end
end
