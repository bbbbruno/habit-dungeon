# frozen_string_literal: true

module ChallengeDecorator
  def final_day
    levels.map(&:days).sum
  end

  def over_last_day?
    progress >= total_days + over_days
  end

  def enemy_max_life
    days_list[current_level]
  end

  def current_level_title
    levels.pluck(:number, :title).to_h[current_level]
  end
end
