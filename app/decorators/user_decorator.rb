# frozen_string_literal: true

module UserDecorator
  def has_dummy_email?
    user_auths.any? { |auth| email == User.dummy_email(auth)  }
  end

  def sns_connected?(provider)
    user_auths.find_by(provider: provider)
  end

  def max_progress
    challenges.pluck(:progress).max
  end

  def challenging?(dungeon)
    challenges.include?(dungeon)
  end

  def already_max_challenge?
    challenges.count >= User::DEFAULT_MAX_CHALLENGE
  end
end
