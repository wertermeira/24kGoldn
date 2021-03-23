class SpotifySaveUriService
  attr_accessor :account
  def initialize(account)
    @account = account
  end

  def call
    spotify.track_save('3tjFYV6RSFtuktYl3ZtYcq')
    spotify.follow(id: '3LAyLwQv3bRS7rlGA46UVF', type: 'playlist')
    spotify.follow(id: '6fWVd57NKTalqvmjRd2t8Z', type: 'artist')
  end

  private

  def spotify
    SpotifyProvider.new(account)
  end
end
