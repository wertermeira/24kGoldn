class PlayerController < ApplicationController
  def create
    SpotifyPlayerService.new(current_user).play_or_resume if current_user.credentials.present?
    render json: '', status: :created
  rescue StandardError => e
    render json: '', status: :not_modified
  end
end