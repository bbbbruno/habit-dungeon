# frozen_string_literal: true

module UserDecorator
  def max_progress
    challenges.pluck(:progress).max
  end
end
