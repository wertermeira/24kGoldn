class SpotifyPlayerService
  attr_accessor :account
  def initialize(account)
    @account = account
  end

  def play_or_resume
    payload = { 
      context_uri: 'spotify:playlist:3LAyLwQv3bRS7rlGA46UVF', 
      offset: {
        position: rand(0..12)
      },
      position_ms: 0
     }
    device_id = get_device
    raise StandardError if device_id.blank?

    spotify.player_play(payload: payload, device_id: device_id)
  end

  def pause
    spotify.player_pause
  end

  def get_device
    devices = spotify.player_devices['devices']
    return if devices.blank?

    devices.first['id']
  end

  private

  def spotify
    SpotifyProvider.new(account)
  end
end
