# frozen_string_literal: true

module UsersHelper
  def difficulty_in_japanese(challenge)
    case challenge.difficulty
    when 'easy'
      '易'
    when 'normal'
      '中'
    when 'hard'
      '難'
    end
  end
end
