# frozen_string_literal: true

class Shop::SessionsController < Devise::SessionsController
  before_action :allow_access

  private

  def allow_access
    if user_signed_in?
      render file: "#{Rails.root}/app/views/errors/404.html", layout: false
      flash.clear
    end
  end
end
