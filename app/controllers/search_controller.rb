class SearchController < ApplicationController

  before_action :set_categories

  def search
    unless params[:query].blank?
      options = { sort: params[:sort] }
      @results = Advertisement.search( params[:query] )
    end
  end

  private

  def set_categories
    @categories = Category.all
  end

end
