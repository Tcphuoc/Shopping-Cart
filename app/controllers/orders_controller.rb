# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :destroy], unless: :shop_signed_in?

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
    @order = Order.new
    if shop_signed_in?
      redirect_to root_url
      return
    end

    if !(cookies[:product_id].nil? || cookies[:product_id].empty?)
      @product = Product.find_by(id: cookies[:product_id])
      @quantity = cookies[:quantity].to_i
      remove_cookies
      @total_price = @quantity * @product.price
    elsif current_user.cart.cart_items.count.positive?
      @cart_items = current_user.cart.cart_items
      @total_price = current_user.cart.total_price
    else
      redirect_to root_url
    end
  end

  def create
    @cart = current_user.cart
    order = Order.new(order_params.except(:product_id, :quantity))
    order_creator = OrderCreator.new(@cart, order, params[:order][:product_id], params[:order][:quantity])
    if order_creator.save
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
    params.require(:order).permit(:user_id, :shop_id, :address, :phone, :total_price, :product_id, :quantity)
  end

  def shop_signed_in?
    return true if current_shop

    false
  end
end
