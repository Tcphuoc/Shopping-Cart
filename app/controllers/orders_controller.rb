# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :destroy], if: :shop_signed_in?
  before_action :create_order_creator, only: [:new, :create]

  def index
    if shop_signed_in?
      @orders = current_shop.orders.page(params[:page]).per(5)
      render 'orders/index_shop'
    elsif user_signed_in?
      @orders = current_user.orders.page(params[:page]).per(5)
      render 'orders/index_user'
    else
      redirect_to root_url
    end
  end

  def new
    @cart_items = @order_creator.cart_items
    @total_price = @order_creator.total_price
  end

  def create
    if @order_creator.save
      flash[:notice] = 'Payment success. You can check your order in Order page'
      redirect_to root_url
    else
      flash.now[:alert] = 'Payment fail. Please check your information'
      @cart_items = @order_creator.cart_items
      @total_price = @order_creator.total_price
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :shop_id, :address, :phone, :total_price, :product_id, :quantity)
  end

  def create_order_creator
    @cart = current_user.cart

    if !(cookies[:product_id].nil? || cookies[:product_id].empty?)
      @order = Order.new
      @order_creator = OrderCreator.new(@cart, @order, cookies[:product_id], cookies[:quantity].to_i)
      remove_cookies
    else
      @order = Order.new(order_params.except(:product_id, :quantity))
      @order_creator = OrderCreator.new(@cart, @order, params[:order][:product_id], params[:order][:quantity])
    end
  end
end
