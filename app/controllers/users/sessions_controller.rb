# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :allow_access
  after_action :create_cart, only: :create

  protected

  def create_cart
    user_id = current_user.id
    Cart.create(user_id: user_id, total_price: 0) if Cart.where(user_id: user_id).empty?
  end

  def allow_access
    if shop_signed_in?
      render file: "#{Rails.root}/app/views/errors/404.html", layout: false
      flash.clear
    end
  end
end
