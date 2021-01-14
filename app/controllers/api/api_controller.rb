class Api::ApiController < ActionController::Base

  before_action :check_login

  def check_login
    render json: {error: 'authentication error'}, status: :unauthorized unless current_user
  end
end