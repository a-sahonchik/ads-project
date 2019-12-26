# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @advertisements = Advertisement.where(state: 'published').order(:id).reverse.first(10)
    @categories = Category.all
  end
end
