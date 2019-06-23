class TracksController < ApplicationController
  before_action :find_track, only: :show

  def show
    @support = Supports::Track.new track, params
    track.increment! :views_count
  end

  private

  attr_reader :track

  def find_track
    @track = Track.find_by id: params[:id]

    return if track
    redirect_back fallback_location: root_path, alert: t("admin.resource.not_found")
  end
end
