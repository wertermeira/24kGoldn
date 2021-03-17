OmniAuth.config.logger = Rails.logger
OmniAuth.config.on_failure = Proc.new { |env|
  Rack::Response.new(["302 Moved"], 302, 'Location' => '/').finish
}
Rails.application.config.middleware.use OmniAuth::Builder do
	provider :spotify,  ENV['SPOTIFY_CLIENT'], ENV['SPOTIFY_SECRET'],
    scope: 'user-read-recently-played user-modify-playback-state user-read-playback-state playlist-read-private user-follow-modify
            playlist-modify-public user-read-private user-read-email user-library-modify user-library-read user-top-read',
      provider_ignores_state: true
end
