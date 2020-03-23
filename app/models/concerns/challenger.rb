# frozen_string_literal: true

module Challenger
  extend ActiveSupport::Concern

  included do
    has_many :challenges,
      -> { order(updated_at: :desc) },
      as: :challenger,
      dependent: :destroy

    def challenge
      challenges.first
    end
  end

  def challenger_name
    raise NotImplementedError
  end

  def all_challengers
    raise NotImplementedError
  end

  def all_challengers_avatar
    raise NotImplementedError
  end
end
