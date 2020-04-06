# frozen_string_literal: true

module ChallengesHelper
  def step_classes(counter, progress)
    if counter < progress
      '_passed'
    elsif counter == progress
      '_now'
    elsif counter > progress
      '_remain'
    end
  end

  def final_classes(challenge)
    if challenge.over_days > 0
      '_over'
    elsif challenge.progress >= challenge.final_day
      '_final'
    end
  end
end
