class AdminController < ApplicationController
  before_action :authenticate_administrator

  def index
    @support = Supports::Admin.new
  end

  protected

  def authenticate_administrator
    return true if current_user&.admin?
    flash[:error] = t(".access_denied")
    redirect_to root_path
  end
end
