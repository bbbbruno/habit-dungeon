# frozen_string_literal: true

class Api::BaseController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end
end
