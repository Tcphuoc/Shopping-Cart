# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  before_action :allow_access

  private

  def allow_access
    render file: "#{Rails.root}/app/views/errors/404.html", layout: false if shop_signed_in?
  end
end
