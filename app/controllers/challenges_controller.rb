# frozen_string_literal: true

class ChallengesController < ApplicationController
  before_action :set_challenge, only: %i[show update destroy]

  def index
    @challenges = Challenge.all
  end

  def show
  end

  def create
    @challenge = Challenge.new(challenge_params)
    @challenge.challenger = current_user if solo?
    @challenge.life = @challenge.max_life
    @challenge.progress = 1

    if @challenge.save
      redirect_to @challenge, notice: "ダンジョンの攻略をはじめました"
    else
      redirect_back fallback_location: root_path, alert: "エラーが発生しました"
    end
  end

  def update
    if @challenge.update(update_challenge_params)
      redirect_to challenge_attacked_url(@challenge), notice: "おめでとうございます！"
    else
      redirect_back fallback_location: root_path, alert: "エラーが発生しました"
    end
  end

  def destroy
    @challenge.destroy
    redirect_to dungeons_url, notice: "ダンジョン攻略をリタイアしました"
  end

  private
    def set_challenge
      @challenge = Challenge.find(params[:id])
    end

    def challenge_params
      params.require(:challenge).permit(:challenger_type, :dungeon_id, :difficulty)
    end

    def update_challenge_params
      params.require(:challenge).permit(:progress, :life, :clear)
    end

    def solo?
      params[:challenge][:challenger_type] == "solo"
    end
end
