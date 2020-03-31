# frozen_string_literal: true

class Users::UserAuthsController < ApplicationController
  before_action :set_user_auth, only: %i[destroy]

  def destroy
    if only_one_sns_connected?
      redirect_to edit_user_registration_path, alert: '解除前に、Eメールログインを追加または違うSNSを連携してください'
    else
      @user_auth.destroy
      redirect_to edit_user_registration_path, notice: "#{params[:provider].capitalize}との連携を解除しました"
    end
  end

  private
    def set_user_auth
      @user_auth = current_user.user_auths.find_by(provider: params[:provider])
    end

    def only_one_sns_connected?
      current_user.has_dummy_email? && current_user.user_auths.count == 1
    end
end
