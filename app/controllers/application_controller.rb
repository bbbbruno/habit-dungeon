# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[avatar user_id name self_introduction twitter_url facebook_url instagram_url])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[avatar user_id name self_introduction twitter_url facebook_url instagram_url])
    end
end
