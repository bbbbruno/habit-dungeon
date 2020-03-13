# frozen_string_literal: true

# == Schema Information
#
# Table name: challenges
#
#  id              :bigint           not null, primary key
#  attacked        :boolean          default("false"), not null
#  challenger_type :string           not null
#  clear           :boolean          default("false"), not null
#  difficulty      :string           default("easy"), not null
#  life            :integer          default("3"), not null
#  progress        :integer          default("1"), not null
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
class Challenge < ApplicationRecord
  belongs_to :challenger, polymorphic: true
  belongs_to :dungeon
  belongs_to :enemy

  validates :difficulty, inclusion: { in: %w[easy normal hard] }
  validates :life,
    numericality: {
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 3,
      message: "入力値が1~3の範囲外です",
    }
  validate :double_challenge
  validate :check_clear, if: :clear?

  def max_life
    life_list = { easy: 3, normal: 2, hard: 1 }
    life_list[difficulty.to_sym]
  end

  private
    def double_challenge
      if Challenge.find_by(challenger: challenger)
        errors.add(:base, "２つ以上のダンジョンを同時に攻略することはできません")
      end
    end

    def check_clear(threshold = 66)
      if progress < threshold
        errors.add(:progress, "が#{threshold}日以上でないとダンジョンはクリアできません")
      end
    end
end
