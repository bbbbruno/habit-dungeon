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
class Enemy < ApplicationRecord
  has_many :challenges
  has_one_attached :image

  validates :level,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 10,
      message: '入力値が1~10の範囲外です',
    }
  validates :name, presence: true, uniqueness: true

  def self.choose(level:)
    where(level: level).sample
  end
end
