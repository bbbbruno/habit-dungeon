# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(user)
    dungeons_path
  end

  def after_sign_out_path_for(user)
    new_user_session_path
  end

  protected
    def configure_permitted_parameters
      additional_colums = %i[avatar user_id name self_introduction twitter_url facebook_url instagram_url]
      devise_parameter_sanitizer.permit(:sign_up, keys: additional_colums)
      devise_parameter_sanitizer.permit(:account_update, keys: additional_colums)
    end
end
