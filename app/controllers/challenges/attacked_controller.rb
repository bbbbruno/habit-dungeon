# frozen_string_literal: true

class Challenges::AttackedController < ApplicationController
  before_action :set_my_challenge

  def show
  end

  private
    def set_my_challenge
      @challenge = current_user.challenges.find(params[:challenge_id])
    end
end
