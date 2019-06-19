class CategoriesController < ApplicationController
  before_action :find_category, only: :show

  def index
    @categories = Category.page(params[:page]).per Settings.category.list
  end

  def show
    @category_albums = category.albums.page(params[:page])
      .per Settings.album.list
  end

  private

  attr_reader :category

  def find_category
    @category = Category.find_by id: params[:id]

    return if category
    redirect_back fallback_location: root_path, alert: t("admin.resource.not_found")
  end
end
