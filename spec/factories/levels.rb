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
    number { 1 }
    title { "MyString" }
    days { 1 }
    dungeon { nil }
  end
end
