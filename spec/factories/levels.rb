# frozen_string_literal: true

# == Schema Information
#
# Table name: levels
#
#  id         :bigint           not null, primary key
#  days       :integer          not null
#  number     :integer          not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  dungeon_id :bigint           not null
#
# Indexes
#
#  index_levels_on_dungeon_id             (dungeon_id)
#  index_levels_on_number_and_dungeon_id  (number,dungeon_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (dungeon_id => dungeons.id)
#
FactoryBot.define do
  factory :level do
    dungeon
    number { 1 }
    sequence(:title) { |n| "本を毎日#{n}ページ読む" }
    days { 11 }
  end
end
