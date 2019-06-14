class Admin::CategoriesController < AdminController
  before_action :find_category, only: %i(edit update destroy)

  def index
    @admin_categories = Category.page(params[:page])
      .per Settings.category.featured_list
  end

  def new
    @admin_category = Category.new
  end

  def edit; end

  def create
    @admin_category = Category.new admin_category_params

    if admin_category.save
      redirect_to admin_categories_path, notice: t(".created")
    else
      render :new
    end
  end

  def update
    if admin_category.update admin_category_params
      redirect_to admin_categories_path, notice: t(".updated")
    else
      render :edit
    end
  end

  def destroy
    if admin_category.destroy
      redirect_to admin_categories_path, notice: t(".destroyed")
    else
      redirect_to admin_categories_path, alert: t(".faild_to_destroyed")
    end
  end

  private

  attr_reader :admin_category

  def find_category
    @admin_category = Category.find_by id: params[:id]

    return if admin_category
    redirect_to admin_categories_path, alert: t("admin.resource.not_found")
  end

  def admin_category_params
    params.require(:admin_category).permit :name
  end
end
