# frozen_string_literal: true

class Dungeon < ApplicationRecord
  belongs_to :user
  has_many :levels
end
