# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ProductsHelper
  include CartsHelper
  include OrdersHelper
  before_action :configure_sign_up_params, if: :devise_controller?
  before_action :check_url

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name phone address])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name phone address])
  end

  def check_url
    redirect_to products_url if request.path_info == '/' && shop_signed_in?
  end
end
