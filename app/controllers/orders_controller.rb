# frozen_string_literal: true

class OrdersController < UsersController
  before_action :initialize_for_new, only: [:new]
  before_action :initialize_for_create, only: [:create]

  def index
    if user_signed_in?
      @orders = current_user.orders.page(params[:page]).per(5)
    else
      redirect_to root_url
    end
  end

  def new
    if @order_creator.items_valid?
      @cart_items = @order_creator.items
      @total_price = @order_creator.total_price
      @product = @order_creator.product
      @quantity = @order_creator.quantity
    else
      flash[:alert] = 'Oops... Your products were changed. Please checking again'
      redirect_to request.referrer || root_url
    end
  end

  def create
    if @order_creator.save
      flash[:notice] = 'Payment success. You can check your order in Order page'
      redirect_to root_url
    else
      @order_creator.reload_cart
      if @order_creator.items_empty?
        flash[:alert] = 'Oops... Your products were changed. Please checking again'
        redirect_to root_url
      else
        flash[:alert] = 'Oops... Something went wrong. Please checking your information and products'
        @cart_items = @order_creator.items
        @total_price = @order_creator.total_price
        @product = @order_creator.product
        @quantity = @order_creator.quantity
        render 'new', status: :unprocessable_entity
      end
    end
  end

  private

  def create_order_creator(product_id, quantity)
    input = {
      cart: current_user.cart,
      order: @order,
      product_id: product_id,
      quantity: quantity
    }

    if product_id.nil? || product_id.empty?
      OrderAddCartService.new(input)
    else
      OrderBuyNowService.new(input)
    end
  end

  def initialize_for_new
    @order = Order.new
    @order_creator = create_order_creator(cookies[:product_id], cookies[:quantity].to_i)
    remove_cookies
  end

  def initialize_for_create
    @order = Order.new(order_params.except(:product_id, :quantity))
    @order_creator = create_order_creator(params[:order][:product_id], params[:order][:quantity].to_i)
  end

  def order_params
    params.require(:order).permit(:user_id, :shop_id, :address, :phone, :total_price, :product_id, :quantity)
  end

  def remove_cookies
    unless cookies[:product_id].nil? || cookies[:product_id].empty?
      cookies[:product_id] = nil
      cookies[:quantity] = nil
    end
  end
end
