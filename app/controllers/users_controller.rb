class UsersController < ApplicationController

  before_action :set_categories
  before_action :set_advertisements, only: [:index, :edit]

  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to request.referrer, alert: exception.message
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @advertisements = Advertisement.where(user_id: @user.id)
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, success: 'Пользователь успешно создан'
    else
      flash[:danger] = 'Ошибка при создании пользователя'
      render 'new'
    end
  end

  def update
     @user = User.find(params[:id])
     if @user.update(user_params)
       redirect_to users_path
     else
       render 'edit'
     end
   end

   def destroy
    @user = User.find(params[:id])
    @user.destroy

    if @user.destroy
        redirect_to users_path, notice: "Пользователь удален."
    end
  end

  private

  def set_categories
    @categories = Category.all
  end

  def set_advertisements
    @advertisements = Advertisement.all.order(:id).reverse
  end

  def user_params
    params.require(:user).permit(:email, :username, :password, role_ids: [])
  end
end
