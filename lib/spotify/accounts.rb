module Spotify
  class Accounts < Spotify::Base
    attr_accessor :account

    def initialize(account)
      @times = 0
      @account = account
    end

    def refresh_token
      return account.credentials['token'] if Time.now.utc.to_i <= account.credentials['expires_at'].to_i

      connect_spotify
    rescue StandardError => e
      sleep 3 unless Rails.env.test?
      Rails.logger.error e
      refresh_token(account: account) if (@times += 1) < 3
    end

    private

    def connect_spotify
      base_url = 'https://accounts.spotify.com/api'
      response = connection(base_url: base_url).post(endpoint: 'token',
                                                     headers: headers,
                                                     payload: build_payload(account))
      raise StandardError if response['access_token'].blank?

      build_credentials(account: account, response: response)
    end

    def build_credentials(account:, response:)
      account.credentials['token'] = response['access_token']
      account.credentials['expires_at'] = (Time.now.utc.to_i + response['expires_in'].to_i)
      response['access_token'] if account.save(validate: false)
    end

    def build_payload(account)
      { grant_type: 'refresh_token', refresh_token: account.credentials['refresh_token'] }
    end

    def headers
      token = Base64.strict_encode64("#{ENV['SPOTIFY_CLIENT']}:#{ENV['SPOTIFY_SECRET']}")
      { Authorization: "Basic #{token}" }
    end
  end
end
