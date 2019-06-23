class AlbumsController < ApplicationController
  before_action :find_album, only: :show

  def show
    @support = Supports::Album.new album, params
    album.increment! :views_count
  end

  private

  attr_reader :album

  def find_album
    @album = Album.find_by id: params[:id]

    return if album
    redirect_back fallback_location: root_path, alert: t("admin.resource.not_found")
  end
end
