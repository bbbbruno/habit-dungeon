# frozen_string_literal: true

# == Schema Information
#
# Table name: challenges
#
#  id              :bigint           not null, primary key
#  attacked        :boolean          default(FALSE), not null
#  challenger_type :string           not null
#  clear           :boolean          default(FALSE), not null
#  difficulty      :string           default("easy"), not null
#  life            :integer          default(3), not null
#  over_days       :integer          default(0), not null
#  progress        :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  challenger_id   :bigint           not null
#  dungeon_id      :bigint           not null
#  enemy_id        :bigint           not null
#
# Indexes
#
#  index_challenges_on_challenger_type_and_challenger_id  (challenger_type,challenger_id)
#  index_challenges_on_dungeon_id                         (dungeon_id)
#  index_challenges_on_enemy_id                           (enemy_id)
#
# Foreign Keys
#
#  fk_rails_...  (dungeon_id => dungeons.id)
#  fk_rails_...  (enemy_id => enemies.id)
#
FactoryBot.define do
  factory :challenge do
    for_user
    dungeon
    difficulty { 'easy' }

    trait :for_user do
      association :challenger, factory: :user
    end

    trait :level2 do
      after(:create) do |challenge|
        challenge.progress = 11
        challenge.enemy = Enemy.find_by(level: 2)
      end
    end
    trait :level3 do
      after(:create) do |challenge|
        challenge.progress = 22
        challenge.enemy =  Enemy.find_by(level: 3)
      end
    end
    trait :over_level do
      after(:create) do |challenge|
        challenge.progress = 70
        challenge.enemy =  Enemy.find_by(level: 6)
      end
    end
  end
end
