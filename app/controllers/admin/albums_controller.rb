class Admin::AlbumsController < AdminController
  before_action :find_admin_album, only: %i(edit update destroy)

  def index
    @admin_albums = Album.page(params[:page])
      .per Settings.album.featured_list
  end

  def new
    @admin_album = Album.new
  end

  def edit; end

  def create
    @admin_album = Album.new admin_album_params

    if admin_album.save
      redirect_to admin_albums_path, notice: t(".created")
    else
      render :new
    end
  end

  def update
    if admin_album.update admin_album_params
      redirect_to admin_albums_path, notice: t(".updated")
    else
      render :edit
    end
  end

  def destroy
    if admin_album.destroy
      redirect_to admin_albums_path, notice: t(".destroyed")
    else
      redirect_to admin_albums_path, alert: t(".faild_to_destroyed")
    end
  end

  private

  attr_reader :admin_album

  def find_admin_album
    @admin_album = Album.find_by id: params[:id]

    return if admin_album
    redirect_to admin_albums_path, alert: t("admin.resource.not_found")
  end

  def admin_album_params
    params.require(:admin_album).permit Album::ALBUM_PARAMS
  end
end
