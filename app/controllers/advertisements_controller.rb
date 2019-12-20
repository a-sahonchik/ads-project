class AdvertisementsController < ApplicationController
  before_action :set_advertisement, only: [:show, :edit, :update, :destroy]
  before_action :set_categories

  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    if request.referrer
      redirect_to request.referrer, alert: exception.message
    else
      render file: "#{Rails.root}/public/403.html" , status: 403
    end
  end

  before_action :authenticate_user!, except: [:index, :show]

  def index
    (@filterrific = initialize_filterrific(
      Advertisement.where(:state => :published),
      params[:filterrific],
      select_options: {
        sorted_by: Advertisement.options_for_sorted_by,
        with_category_id: Category.options_for_select,
      },
    )) || return
    @advertisements = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
    @advertisement = Advertisement.new
  end

  def edit
  end

  def create
    @advertisement = Advertisement.new(advertisement_params)
    @advertisement.user = current_user

    if @advertisement.save
      redirect_to @advertisement, success: 'Объявление успешно создано'
    else
      flash[:danger] = 'Ошибка при создании объявления'
      render 'new'
    end
  end

  def update
    if @advertisement.update(advertisement_params)
      redirect_to @advertisement, success: 'Объявление успешно изменено'
    else
      flash[:danger] = 'Ошибка при изменении объявления'
      render 'edit'
    end
  end

  def destroy
    @advertisement.destroy

    redirect_to advertisements_path, success: 'Объявление успешно удалено'
  end

  def user_advertisements
    @advertisements = Advertisement.where(user_id: current_user.id).order("updated_at DESC")
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
      params.require(:advertisement).permit(:ad_title, :ad_text, :category_id, :state_event, :picture)
    end
end
