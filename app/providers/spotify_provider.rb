class SpotifyProvider
  attr_accessor :account
  def initialize(account)
    @account = account
  end

  def follow(id:, type: 'artist')
    options = { type: type, id: id }
    spotify_follow.save(options)
  end

  def track_save(id)
    spotify_track.save(id)
  end

  def album_save(id)
    spotify_album.save(id)
  end

  def player_play(payload:, device_id:)
    spotify_player.play(payload: payload, device_id: device_id)
  end

  def player_devices
    spotify_player.devices
  end

  def player_pause
    spotify_player.pause
  end

  def player_repeat(device_id:, state: 'track')
    spotify_player.repeat(device_id: device_id, state: state)
  end

  private

  def spotify_player
    Spotify::User.new(token)
  end

  def spotify_follow
    Spotify::Follow.new(token)
  end

  def spotify_track
    Spotify::Track.new(token)
  end

  def spotify_album
    Spotify::Album.new(token)
  end

  def token
    Spotify::Accounts.new(account).refresh_token
  end
end
