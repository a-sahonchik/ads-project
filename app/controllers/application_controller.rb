# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :success, :danger

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    if request.referrer
      redirect_to request.referrer, alert: exception.message
    else
      render file: "#{Rails.root}/public/403.html", status: 403
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username email password current_password])
  end
end
