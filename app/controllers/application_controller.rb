class ApplicationController < ActionController::API
  before_action :require_login
  include ActionController::HttpAuthentication::Token::ControllerMethods

  private

  def current_user
    @authenticate_token
  end

  def require_login
    auth = authenticate_token
    return @authenticate_token = authenticate_token if auth

    render_unauthorized('Access denied')
  end

  def authenticate_token
    authenticate_with_http_token do |token|
      User.find_by(token: token)
    end
  end

  def render_unauthorized(message)
    errors = { default_error: message }
    render json: errors, status: :unauthorized
  end
end
