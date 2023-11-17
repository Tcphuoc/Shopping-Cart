# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :allow_access

  protected

  def after_update_path_for(resource)
    edit_user_registration_path(resource)
  end

  def allow_access
    if shop_signed_in?
      render file: "#{Rails.root}/app/views/errors/404.html", layout: false
      flash.clear
    end
  end
end
