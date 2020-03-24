# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!, only: %i[index update]
  before_action :set_my_notification, only: %i[update]

  def index
    @notifications = current_user
                      .notifications
                      .includes(:sender)
                      .order(created_at: :desc)
                      .page(params[:page])
  end

  def update
    @notification.read! if @notification.unread?
    redirect_to @notification.path
  end

  private
    def set_my_notification
      @notification = current_user.notifications.find(params[:id])
    end
end
