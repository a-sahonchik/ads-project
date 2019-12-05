class WelcomeController < ApplicationController
  def index
    @advertisements = Advertisement.all.order(:id).reverse.first(10)
    @categories = Category.all
  end
end
