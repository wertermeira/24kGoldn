class AuthenticationsController < ApplicationController
  skip_before_action :require_login
  def create
    if request.post?
      guest_user
    else
      spotify_user
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e }, status: :unprocessable_entity
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def guest_user
    user = User.create
    render json: { token: user.token }, status: :created
  end

  def spotify_user
    user = AuthService.new(auth_hash).call
    SpotifySaveUriService.new(user).call

    url_callback = request.env['omniauth.params']['url_callback']
    redirect_to "#{url_callback}?token=#{user.token}"
  end
end