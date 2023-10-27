# frozen_string_literal: true

class Shop::RegistrationsController < Devise::RegistrationsController
  protected

  def after_update_path_for(resource)
    edit_shop_registration_path(resource)
  end
end
