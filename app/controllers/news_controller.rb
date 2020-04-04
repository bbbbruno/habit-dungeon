# frozen_string_literal: true

class NewsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin_user!, only: %i[new create update destroy]
  before_action :set_news, only: %i[show edit update destroy]

  def index
    if admin_user_signed_in?
      news_index = News.all
    else
      news_index = News.published
    end
    @news_index = news_index.order(created_at: :desc).page(params[:page])
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new(news_params)
    if @news.save
      redirect_to @news, notice: 'お知らせの作成に成功しました'
    else
      render :new
    end
  end

  def show
    redirect_to news_index_url, alert: '不正なアクセスです' if !admin_user_signed_in? && @news.draft?
  end

  def edit
  end

  def update
    if @news.update(news_params)
      redirect_to @news, notice: 'お知らせの更新に成功しました'
    else
      render :edit
    end
  end

  def destroy
    @news.destroy
    redirect_to news_index_url, notice: 'ダンジョンの更新に成功しました'
  end

  private
    def news_params
      params.require(:news).permit(:title, :content, :status)
    end

    def set_news
      @news = News.find(params[:id])
    end
end
