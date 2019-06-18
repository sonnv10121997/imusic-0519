class Admin::UsersController < AdminController
  before_action :find_admin_user, only: %i(edit update destroy)

  def index
    @admin_users = User.page(params[:page])
      .per Settings.user.featured_list
  end

  def new
    @admin_user = User.new
  end

  def edit; end

  def create
    @admin_user = User.new admin_user_params

    if admin_user.save
      redirect_to admin_users_path, notice: t(".created")
    else
      render :new
    end
  end

  def update
    if admin_user.update admin_user_params
      redirect_to admin_users_path, notice: t(".updated")
    else
      render :edit
    end
  end

  def destroy
    if admin_user.destroy
      redirect_to admin_users_path, notice: t(".destroyed")
    else
      redirect_to admin_users_path, alert: t(".faild_to_destroyed")
    end
  end

  private

  attr_reader :admin_user

  def find_admin_user
    @admin_user = User.find_by id: params[:id]

    return if admin_user
    redirect_to admin_users_path, alert: t("admin.resource.not_found")
  end

  def admin_user_params
    params.require(:admin_user).permit User::USER_PARAMS
  end
end
