# frozen_string_literal: true

class NewsController < ApplicationController
  before_action :set_news, only: %i[show]

  def index
    @news_index = News.order(created_at: :desc).page(params[:page])
  end

  def show
  end

  private
    def set_news
      @news = News.find(params[:id])
    end
end
