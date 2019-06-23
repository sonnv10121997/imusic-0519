class Supports::Search
  attr_reader :tracks, :albums, :artists, :params

  def initialize tracks, albums, artists, params
    @tracks = tracks
    @albums = albums
    @artists = artists
    @params = params
  end

  def items
    tracks + albums + artists
  end

  def paginate_tracks
    tracks.page(params[:page]).per Settings.track.list
  end

  def paginate_albums
    albums.page(params[:page]).per Settings.album.list
  end

  def paginate_artists
    artists.page(params[:page]).per Settings.artist.list
  end
end
