class FavouritesController < ApplicationController
  def index
    @support = Supports::HomePage.new params
  end

  def create
    favourite =
      current_user.favourites.build favourable_id: favourite_params[:favourable_id],
        favourable_type: favourite_params[:favourable_type]
    favourite.save
  end

  def destroy
    favourite =
      current_user.favourites.where(favourable_id: favourite_params[:favourable_id],
        favourable_type: favourite_params[:favourable_type]).first
    favourite.destroy
  end

  private

  def favourite_params
    params.require(:favourite).permit :favourable_id, :favourable_type
  end
end
