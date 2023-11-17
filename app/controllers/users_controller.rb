# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :allow_access
  before_action :authenticate_user!

  private

  def allow_access
    render file: "#{Rails.root}/app/views/errors/404.html", layout: false if shop_signed_in?
  end
end
