# frozen_string_literal: true

class Api::Dungeons::LevelsController < Api::BaseController
  before_action :set_dungeon, only: %i[index]

  def index
    @levels = @dungeon.levels
  end

  private
    def set_dungeon
      @dungeon = Dungeon.find(params[:dungeon_id])
    end
end
