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
class Level < ApplicationRecord
  default_scope -> { order(:number) }

  belongs_to :dungeon

  validates :number,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 10,
      message: "入力値が1~10の範囲外です",
    }
  validates :title, presence: true
  validates :days,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 31,
      message: "入力値が1~31の範囲外です",
    }
end
