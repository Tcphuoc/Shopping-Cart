# frozen_string_literal: true

class Shop::RegistrationsController < Devise::RegistrationsController
  before_action :allow_access

  protected

  def after_update_path_for(resource)
    edit_shop_registration_path(resource)
  end

  def allow_access
    if user_signed_in?
      render file: "#{Rails.root}/app/views/errors/404.html", layout: false
      flash.clear
    end
  end
end
