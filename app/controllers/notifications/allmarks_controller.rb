# frozen_string_literal: true

class Notifications::AllmarksController < ApplicationController
  def create
    @notifications = current_user.notifications
    @notifications.update_all(read: true)
    redirect_back fallback_location: root_path, notice: "全て既読にしました"
  end
end
