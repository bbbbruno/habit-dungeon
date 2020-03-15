# frozen_string_literal: true

module ChallengeDecorator
  def final_day
    levels.map(&:days).sum
  end
end
