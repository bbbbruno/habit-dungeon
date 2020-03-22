# frozen_string_literal: true

# == Schema Information
#
# Table name: dungeons
#
#  id           :bigint           not null, primary key
#  description  :text
#  discarded_at :datetime
#  title        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_dungeons_on_discarded_at  (discarded_at)
#  index_dungeons_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Dungeon < ApplicationRecord
  include Discard::Model
  default_scope -> { kept }

  after_discard do
    destroy unless challenges.exists?
  end

  belongs_to :user
  has_one_attached :header
  has_many :levels, dependent: :destroy
  has_many :challenges
  has_many :solos, through: :challenges, source: :challenger, source_type: "User"

  accepts_nested_attributes_for :levels, allow_destroy: true

  validates :title, presence: true
  validates :description, presence: true
  validate :levels_days_exceed

  def destroy_if_no_challenges
    destroy unless challenges.exists?
  end

  def all_uniq_challengers
    solos.includes(:challenges).uniq
  end

  private
    def levels_days_exceed(threshold = 66)
      total = levels.map(&:days).sum
      if total < threshold
        errors.add(:levels, "の合計日数は#{threshold}日以上でなければなりません")
      end
    end
end
