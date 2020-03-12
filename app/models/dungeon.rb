# frozen_string_literal: true

# == Schema Information
#
# Table name: dungeons
#
#  id          :bigint           not null, primary key
#  description :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_dungeons_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Dungeon < ApplicationRecord
  belongs_to :user
  has_one_attached :header
  has_many :levels, dependent: :destroy
  accepts_nested_attributes_for :levels, allow_destroy: true

  validates :title, presence: true
  validates :description, presence: true
  validate :levels_days_over_66

  private
    def levels_days_over_66
      days_list = levels.map(&:days)
      total = days_list.inject(0) { |result, days| result + days }
      if total < 66
        errors.add(:levels, "の合計日数は66日以上でなければなりません")
      end
    end
end
