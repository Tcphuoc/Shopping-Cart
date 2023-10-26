class ApplicationController < ActionController::Base
  before_action :configure_sign_up_params, if: :devise_controller?

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name phone address])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name phone address])
  end
end
