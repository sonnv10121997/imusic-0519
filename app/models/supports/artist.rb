class Supports::Artist
  attr_reader :artist, :params

  def initialize artist, params
    @artist = artist
    @params = params
  end

  def artist_tracks
    artist.tracks.page(params[:page]).per Settings.track.list
  end

  def artist_albums
    artist.albums.page(params[:page]).per Settings.album.featured_list
  end
end
