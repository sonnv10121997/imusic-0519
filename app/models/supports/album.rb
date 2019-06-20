class Supports::Album
  attr_reader :album, :params

  def initialize album, params
    @album = album
    @params = params
  end

  def album_tracks
    album.tracks.page(params[:page]).per Settings.track.small_list
  end
end
