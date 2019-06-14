class Admin::ArtistsController < AdminController
  before_action :set_admin_artist, only: %i(edit update destroy)

  def index
    @admin_artists = Artist.page(params[:page])
      .per Settings.artist.featured_list
  end

  def new
    @admin_artist = Artist.new
  end

  def edit; end

  def create
    @admin_artist = Artist.new admin_artist_params

    if admin_artist.save
      redirect_to admin_artists_path, notice: t(".created")
    else
      render :new
    end
  end

  def update
    if admin_artist.update admin_artist_params
      redirect_to admin_artists_path, notice: t(".updated")
    else
      render :edit
    end
  end

  def destroy
    if admin_artist.destroy
      redirect_to admin_artists_path, notice: t(".destroyed")
    else
      redirect_to admin_artists_path, alert: t(".faild_to_destroyed")
    end
  end

  private

  attr_reader :admin_artist

  def set_admin_artist
    @admin_artist = Artist.find_by id: params[:id]

    return if admin_artist
    redirect_to admin_artists_path, alert: t("admin.resource.not_found")
  end

  def admin_artist_params
    params.require(:admin_artist).permit Artist::ARTIST_PARAMS
  end
end
