class AdminController < ApplicationController
  before_action :authenticate_administrator, only: :index

  def index; end
end
