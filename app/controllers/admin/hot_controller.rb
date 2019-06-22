class Admin::HotController < AdminController
  def index; end

  def update
    Track.where(hot: true).update hot: false
    Album.where(hot: true).update hot: false
    Track.where({id: hot_params[:track_ids]}).update hot: true
    Album.where({id: hot_params[:album_ids]}).update hot: true
    redirect_to admin_hot_path, notice: t(".updated")
  end

  private

  def hot_params
    params.require(:hot).permit track_ids: [], album_ids: []
  end
end
