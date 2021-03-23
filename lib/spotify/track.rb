module Spotify
  class Track < Spotify::Base
    attr_accessor :token

    def initialize(token)
      @token = token
    end

    def save(id)
      connection.put(endpoint: "me/tracks?ids=#{id}", headers: headers)
    end
  end
end
