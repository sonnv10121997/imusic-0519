class AdminController < ApplicationController
  before_action :authenticate_administrator

  def index
    @category_size = Category.pluck(:id).size
  end

  protected

  def authenticate_administrator
    return true if current_user&.admin?
    flash[:error] = t(".access_denied")
    redirect_to root_path
  end
end
