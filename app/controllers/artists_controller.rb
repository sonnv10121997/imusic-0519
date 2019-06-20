class ArtistsController < ApplicationController
  before_action :find_artist, only: :show

  def show
    @support = Supports::Artist.new artist, params
  end

  private

  attr_reader :artist

  def find_artist
    @artist = Artist.find_by id: params[:id]

    return if artist
    redirect_back fallback_location: root_path, alert: t("admin.resource.not_found")
  end
end
