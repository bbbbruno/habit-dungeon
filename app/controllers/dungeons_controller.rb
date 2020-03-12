# frozen_string_literal: true

class DungeonsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create update destroy]
  before_action :set_dungeon, only: %i[show]
  before_action :set_my_dungeon, only: %i[edit update destroy]

  def index
    @dungeons = Dungeon.all
  end

  def show
  end

  def new
    @dungeon = Dungeon.new
  end

  def edit
  end

  def create
    @dungeon = Dungeon.new(dungeon_params)
    @dungeon.user = current_user

    if @dungeon.save
      redirect_to @dungeon, notice: "ダンジョンの作成に成功しました"
    else
      render :new
    end
  end

  def update
    if @dungeon.update(update_dungeon_params)
      redirect_to @dungeon, notice: "ダンジョンの更新に成功しました"
    else
      render :edit
    end
  end

  def destroy
    @dungeon.destroy
    redirect_to dungeons_url, notice: "ダンジョンの削除に成功しました"
  end

  private
    def set_dungeon
      @dungeon = Dungeon.find(params[:id])
    end

    def set_my_dungeon
      @dungeon = current_user.dungeons.find(params[:id])
    end

    def dungeon_params
      params.require(:dungeon).permit(:title, :description, :header, levels_attributes: %i[number title days])
    end

    def update_dungeon_params
      params.require(:dungeon).permit(:title, :description, :header, levels_attributes: %i[id number title days _destroy])
    end
end
