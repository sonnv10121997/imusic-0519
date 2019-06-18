class Admin::TracksController < AdminController
  before_action :find_admin_track, only: %i(edit update destroy)

  def index
    @admin_tracks = Track.page(params[:page])
      .per Settings.track.featured_list
  end

  def new
    @admin_track = Track.new
  end

  def edit; end

  def create
    @admin_track = Track.new admin_track_params

    if admin_track.save
      redirect_to admin_tracks_path, notice: t(".created")
    else
      render :new
    end
  end

  def update
    if admin_track.update admin_track_params
      redirect_to admin_tracks_path, notice: t(".updated")
    else
      render :edit
    end
  end

  def destroy
    if admin_track.destroy
      redirect_to admin_tracks_path, notice: t(".destroyed")
    else
      redirect_to admin_tracks_path, alert: t(".faild_to_destroyed")
    end
  end

  private

  attr_reader :admin_track

  def find_admin_track
    @admin_track = Track.find_by id: params[:id]

    return if admin_track
    redirect_to admin_tracks_path, alert: t("admin.resource.not_found")
  end

  def admin_track_params
    params.require(:admin_track).permit Track::TRACK_PARAMS
  end
end
