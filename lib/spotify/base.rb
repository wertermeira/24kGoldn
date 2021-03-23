module Spotify
  class Base
    private

    def connection(base_url: 'https://api.spotify.com/v1')
      ConnectionExternal.new(base_url: base_url)
    end

    def headers
      {
        Authorization: "Bearer #{token}",
        'Content-Type': 'application/json'
      }
    end
  end
end
