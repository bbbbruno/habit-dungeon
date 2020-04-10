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
class Challenge < ApplicationRecord
  belongs_to :challenger, polymorphic: true
  belongs_to :dungeon, -> { unscope(where: :discarded_at) }
  belongs_to :enemy

  validates :difficulty, inclusion: { in: %w[easy normal hard] }
  validates :life,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 3,
      message: '入力値が0~3の範囲外です',
    }
  validate :over_challenge, on: :create
  validate :discarded_challenge, on: :create
  validate :check_clear, if: :clear?

  delegate :challenger_name, :all_challengers, :all_challengers_avatar, to: :challenger
  delegate :title, :levels, :header, to: :dungeon
  delegate :name, :image, to: :enemy, prefix: true

  before_validation :set_initial_life_and_enemy, on: :create
  before_update :check_rank_up_or_rank_down

  def max_life
    life_list = { easy: 3, normal: 2, hard: 1 }
    life_list[difficulty.to_sym]
  end

  def days_list
    levels.pluck(:number, :days).to_h
  end

  def current_level
    return last_level if over_last_level?
    each_level_start
      .values
      .each_cons(2)
      .each
      .with_index(1) do |array, index|
        return index if progress.between?(array[0], array[1] - 1)
      end
  end

  def enemy_life
    return 0 if over_last_level?
    each_level_start[current_level + 1] - progress
  end

  def rank_up
    return if over_last_level?
    self.enemy = Enemy.choose(level: current_level)
  end

  def rank_down
    return if over_last_level?
    previous_level = current_level - 1
    if previous_level > 0
      self.progress = each_level_start[previous_level]
    else
      self.progress = 0
    end
    self.enemy = Enemy.choose(level: current_level)
    self.life = max_life
  end

  def life_up
    self.life += 1 unless life == max_life
  end

  def deal_damage
    life_before_update = life
    update(attacked: false, life: life - 1)
    Notification.notify_challenge_damaged(self) unless life_before_update == 1
  end

  def at_level_start?
    progress == each_level_start[current_level]
  end

  private
    def over_challenge
      if Challenge.where(challenger: challenger).count >= User::DEFAULT_MAX_CHALLENGE
        errors.add(:base, "#{User::DEFAULT_MAX_CHALLENGE + 1}つ以上のダンジョンを同時に攻略することはできません")
      end
    end

    def discarded_challenge
      if dungeon.discarded?
        errors.add(:base, '削除されたダンジョンを攻略することはできません')
      end
    end

    def check_clear(threshold = 66)
      if progress < threshold
        errors.add(:progress, "が#{threshold}日以上でないとダンジョンはクリアできません")
      end
      if progress < total_days
        errors.add(:base, '最終レベルをクリアしていないとダンジョンはクリアできません')
      end
    end

    def set_initial_life_and_enemy
      self.life = max_life
      self.enemy = Enemy.choose(level: 1)
    end

    def check_rank_up_or_rank_down
      return if over_last_level?
      if life == 0
        rank_down
        Notification.notify_rank_downed(self)
      elsif attacked? && at_level_start?
        rank_up
        life_up
      end
    end

    def total_days
      levels.pluck(:days).sum
    end

    def each_level_start
      levels
        .pluck(:days)
        .each_with_index
        .with_object([0]) do |(days, index), array|
          array << array[index] + days
        end.map
        .with_index(1) do |days, index|
          [index, days]
        end.to_h
    end

    def over_last_level?
      progress >= each_level_start[last_level + 1]
    end

    def last_level
      levels.last.number
    end
end
