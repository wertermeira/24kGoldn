module Spotify
  class Album < Spotify::Base
    attr_accessor :token

    def initialize(token)
      @token = token
    end

    def save(id)
      connection.put(endpoint: "me/albums?ids=#{id}", headers: headers)
    end
  end
end
