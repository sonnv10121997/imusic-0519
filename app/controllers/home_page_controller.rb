class HomePageController < ApplicationController
  def index
    @support = Supports::HomePage.new params
  end
end
