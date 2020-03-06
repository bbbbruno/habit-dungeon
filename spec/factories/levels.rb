# frozen_string_literal: true

FactoryBot.define do
  factory :level do
    number { 1 }
    title { "MyString" }
    days { 1 }
    dungeon { nil }
  end
end
