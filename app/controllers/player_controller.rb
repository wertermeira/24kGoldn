class PlayerController < ApplicationController
  def create
    SpotifyPlayerService.new(current_user).play_or_resume
    render json: '', serializer: UserSerializer, status: :created
  rescue StandardError => e
    render json: '', status: :not_modified
  end
end