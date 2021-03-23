module Spotify
  class Follow < Spotify::Base
    attr_accessor :token

    def initialize(token)
      @token = token
    end

    def save(options)
      connection.put(endpoint: build_endpoint(options), headers: headers)
    end

    private

    def build_endpoint(options)
      options = { type: options[:type], ids: options[:id] }
      case options[:type]
      when 'artist'
        "me/following?#{options.to_query}"
      when 'playlist'
        "playlists/#{options[:ids]}/followers"
      end
    end
  end
end
