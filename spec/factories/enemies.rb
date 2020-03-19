# frozen_string_literal: true

# == Schema Information
#
# Table name: enemies
#
#  id         :bigint           not null, primary key
#  level      :integer          not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :enemy do
    name { "MyString" }
  end
end
