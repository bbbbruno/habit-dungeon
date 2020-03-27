# frozen_string_literal: true

class Users::UserAuthsController < ApplicationController
  before_action :set_user_auth, only: %i[destroy]

  def destroy
    @user_auth.destroy
    redirect_to edit_user_registration_path, notice: "#{params[:provider].capitalize}との連携を解除しました"
  end

  private
    def set_user_auth
      @user_auth = current_user.user_auths.find_by(provider: params[:provider])
    end
end
