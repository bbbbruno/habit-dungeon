# frozen_string_literal: true

module Challenger
  extend ActiveSupport::Concern

  included do
    has_many :challenges, as: :challenger
  end

  def challenger_name
    raise NotImplementedError
  end

  def all_challengers_avatar
    raise NotImplementedError
  end
end
