class WelcomeController < ApplicationController
  def index
    @advertisements = Advertisement.all
    @categories = Category.all
  end
end
