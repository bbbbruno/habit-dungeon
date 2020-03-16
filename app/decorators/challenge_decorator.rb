# frozen_string_literal: true

module ChallengeDecorator
  def final_day
    levels.map(&:days).sum
  end

  def over_last_day?
    progress >= total_days + over_days
  end
end
