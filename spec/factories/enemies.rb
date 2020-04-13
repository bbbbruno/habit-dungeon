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
# Indexes
#
#  index_enemies_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :enemy do
    trait :slime do
      level { 1 }
      name { 'スライム' }
      after(:build) do |enemy|
        enemy.image.attach(
          io: File.open(Rails.root.join('app', 'frontend', 'images', 'level1', 'slime.png')),
          filename: 'slime.png',
          content_type: 'image/png'
        )
      end
    end
    trait :snake do
      level { 2 }
      name { 'スネーク' }
      after(:build) do |enemy|
        enemy.image.attach(
          io: File.open(Rails.root.join('app', 'frontend', 'images', 'level2', 'snake.png')),
          filename: 'snake.png',
          content_type: 'image/png'
        )
      end
    end
    trait :hydra do
      level { 3 }
      name { 'ヒドラ' }
      after(:build) do |enemy|
        enemy.image.attach(
          io: File.open(Rails.root.join('app', 'frontend', 'images', 'level3', 'hydra.png')),
          filename: 'hydra.png',
          content_type: 'image/png'
        )
      end
    end
    trait :witch do
      level { 4 }
      name { 'ウィッチ' }
      after(:build) do |enemy|
        enemy.image.attach(
          io: File.open(Rails.root.join('app', 'frontend', 'images', 'level4', 'witch.png')),
          filename: 'which.png',
          content_type: 'image/png'
        )
      end
    end
    trait :panda do
      level { 5 }
      name { 'パンダ' }
      after(:build) do |enemy|
        enemy.image.attach(
          io: File.open(Rails.root.join('app', 'frontend', 'images', 'level5', 'panda.png')),
          filename: 'panda.png',
          content_type: 'image/png'
        )
      end
    end
    trait :medusa do
      level { 6 }
      name { 'メデューサ' }
      after(:build) do |enemy|
        enemy.image.attach(
          io: File.open(Rails.root.join('app', 'frontend', 'images', 'level6', 'medusa.png')),
          filename: 'medusa.png',
          content_type: 'image/png'
        )
      end
    end
  end
end
