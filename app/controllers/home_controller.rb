# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :logged_in?, only: %i[index]

  def index
    @challenges = current_user.challenges
  end

  private
    def logged_in?
      redirect_to page_path('about') unless user_signed_in?
    end
end
