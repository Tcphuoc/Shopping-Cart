# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :destroy], unless: :shop_signed_in?

  def index
  end

  def new
    @order = Order.new
    @cart = current_user.cart
  end

  def create
    cart = current_user.cart
    order = Order.new(order_params)
    if order.save
      order.create_order_items(cart)
      cart.remove_all_items
      flash[:notice] = 'Payment success. You can check your order in Order page'
      redirect_to root_url
    else
      flash.now[:alert] = 'Payment fail. Please check your information'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :shop_id, :status, :address, :phone, :total_price)
  end

  def shop_signed_in?
    return true if current_shop

    false
  end
end
