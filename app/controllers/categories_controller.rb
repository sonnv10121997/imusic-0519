class CategoriesController < ApplicationController
  def index
    @categories = Category.page(params[:page]).per Settings.category.list
  end

  def show; end
end
