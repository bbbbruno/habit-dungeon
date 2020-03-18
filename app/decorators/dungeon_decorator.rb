# frozen_string_literal: true

module DungeonDecorator
  def all_uniq_challengers
    solos.uniq
  end
end
