module Spotify
  class User < Spotify::Base
    attr_accessor :token

    def initialize(token)
      @token = token
    end

    def play(payload:, device_id:)
      connection.put(endpoint: "me/player/play?device_id=#{device_id}", headers: headers, payload: payload.to_json)
    end

    def devices
      connection.get(endpoint: 'me/player/devices', headers: headers)
    end

    def pause
      connection.put(endpoint: 'me/player/pause', headers: headers)
    end

    def currently_playing
      connection.get(endpoint: 'me/player/currently-playing', headers: headers)
    end

    def repeat(device_id:, state:)
      params = {
        device_id: device_id, state: state
      }.to_query
      connection.put(endpoint: "me/player/repeat?#{params}", headers: headers)
    end
  end
end
