# frozen_string_literal: true

# == Schema Information
#
# Table name: enemies
#
#  id         :bigint           not null, primary key
#  image_url  :string           not null
#  level      :integer          not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Enemy < ApplicationRecord
  has_many :challenges

  validates :level,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 10,
      message: "入力値が1~10の範囲外です",
    }
  validates :name, presence: true
  validates :image_url, presence: true

  def self.choose(level:)
    where(level: level).sample
  end
end
