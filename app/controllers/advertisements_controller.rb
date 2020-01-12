# frozen_string_literal: true

class AdvertisementsController < ApplicationController
  before_action :set_advertisement, only: %i[show edit update destroy]
  before_action :set_categories

  load_and_authorize_resource

  before_action :authenticate_user!, except: %i[index show]

  def index
    (@filterrific = initialize_filterrific(
      Advertisement.where(state: :published), params[:filterrific],
      select_options: {
        sorted_by: Advertisement.options_for_sorted_by,
        with_category_id: Category.options_for_select
      }
    )) || return
    @advertisements = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show; end

  def new
    @advertisement = Advertisement.new
  end

  def edit; end

  def create
    @advertisement = current_user.advertisements.new(advertisement_params)

    if @advertisement.save
      redirect_to @advertisement, success: I18n.t('advertisement.create_action.success')
    else
      flash[:danger] = I18n.t('advertisement.create_action.danger')
      render 'new'
    end
  end

  def update
    if @advertisement.update(advertisement_params)
      redirect_to @advertisement, success: I18n.t('advertisement.edit.success')
    else
      flash[:danger] = I18n.t('advertisement.edit.danger')
      render 'edit'
    end
  end

  def destroy
    @advertisement.destroy

    redirect_to advertisements_path, success: I18n.t('advertisement.destroy.success')
  end

  def user_advertisements
    @advertisements = @current_user.advertisements.order('updated_at DESC')
    @states = Advertisement.state_machine.states.map &:value
  end

  def opened_advertisements
    @advertisements = Advertisement.where(state: 'opened')
  end

  private

  def set_categories
    @categories = Category.all
  end

  def set_advertisement
    @advertisement = Advertisement.find(params[:id])
  end

  def advertisement_params
    params.require(:advertisement).permit(:ad_title, :ad_text, :category_id, :state_event, pictures: [])
  end
end
