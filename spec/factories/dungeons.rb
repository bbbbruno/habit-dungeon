# frozen_string_literal: true

FactoryBot.define do
  factory :dungeon do
    title { "MyString" }
    description { "MyText" }
    user { nil }
  end
end
