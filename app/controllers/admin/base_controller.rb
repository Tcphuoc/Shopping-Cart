# frozen_string_literal: true

class Admin::BaseController < ApplicationController
  before_action :allow_access
  before_action :authenticate_shop!

  private

  def allow_access
    render file: "#{Rails.root}/app/views/errors/404.html", layout: false if user_signed_in?
  end
end
