class HitController < ApplicationController
  before_action :find_track, :find_album

  def play
    album.increment! :play_count
    track.increment! :play_count
  end

  private

  attr_reader :album, :track

  def find_album
    @album = Album.find_by id: hit_params[:album_id]

    return if album
    redirect_to root_path, alert: t("admin.resource.not_found")
  end

  def find_track
    @track = Track.find_by id: hit_params[:track_id]

    return if track
    redirect_to root_path, alert: t("admin.resource.not_found")
  end

  def hit_params
    params.require(:hit).permit :track_id, :album_id
  end
end
