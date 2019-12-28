# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]
  before_action :set_categories, only: %i[index show new edit create]

  load_and_authorize_resource

  def index; end

  def show
    @advertisements = @category.advertisements.where(state: 'published').order('updated_at DESC').paginate(page: params[:page], per_page: 10)
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, success: I18n.t('category.actions.create.success')
    else
      flash[:danger] = I18n.t('category.actions.create.danger')
      render 'new'
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, success: I18n.t('category.actions.update.success')
    else
      flash[:danger] = I18n.t('category.actions.update.danger')
      render 'edit'
    end
  end

  def destroy
    if @category.advertisements.any?
      redirect_to categories_path, danger: I18n.t('category.actions.destroy.danger')
    else
      @category.destroy

      redirect_to categories_path, success: I18n.t('category.actions.destroy.success')
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
