class SearchesController < ApplicationController
  def index
    q = params[:q]
    tracks = Track.ransack(title_or_artist_name_or_album_name_cont: q)
      .result distinct: true
    albums = Album.ransack(name_cont: q).result distinct: true
    artists = Artist.ransack(name_cont: q).result distinct: true
    @support = Supports::Search.new tracks, albums, artists, params
  end
end
