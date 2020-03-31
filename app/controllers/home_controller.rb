# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :logged_in?, only: %i[index]

  def index
    @challenges = current_user
                    .challenges
                    .includes(:challenger, :enemy, dungeon: [{ header_attachment: :blob }, :levels])
                    .unscope(:order)
                    .order(created_at: :asc)
                    .page(params[:page])
                    .per(1)
  end

  private
    def logged_in?
      redirect_to page_path('about') unless user_signed_in?
    end
end
