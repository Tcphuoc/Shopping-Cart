# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :destroy], unless: :shop_signed_in?

  def index
    if shop_signed_in?
      render 'orders/index_shop'
    elsif user_signed_in?
      render 'orders/index_user'
    else
      redirect_to root_url
    end
  end

  def new
    @order = Order.new
    @cart = current_user.cart
  end

  def create
    cart = current_user.cart
    order = Order.new(order_params)
    if order.save
      order_creator = OrderCreator.new(cart, order)
      order_creator.create_order_items
      order_creator.send_email
      flash[:notice] = 'Payment success. You can check your order in Order page'
      redirect_to root_url
    else
      @cart = cart
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
