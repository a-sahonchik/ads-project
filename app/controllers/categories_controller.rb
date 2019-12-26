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
      redirect_to categories_path, success: 'Тип успешно добавлен'
    else
      flash[:danger] = 'Ошибка при создании типа'
      render 'new'
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, success: 'Тип успешно изменен'
    else
      flash[:danger] = 'Ошибка при изменении типа'
      render 'edit'
    end
  end

  def destroy
    if @category.advertisements.any?
      redirect_to categories_path, danger: 'Нельзя удалить, есть вложенные объявления!'
    else
      @category.destroy

      redirect_to categories_path, success: 'Тип успешно удален'
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
