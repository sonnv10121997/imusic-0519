class HomePageController < ApplicationController
  def index
    @support = Supports::HomePage.new
  end
end
