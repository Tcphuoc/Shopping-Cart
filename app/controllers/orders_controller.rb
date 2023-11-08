# frozen_string_literal: true

class OrdersController < UsersController
  def index
    if user_signed_in?
      @orders = current_user.orders.page(params[:page]).per(5)
    else
      redirect_to root_url
    end
  end

  def new
    @order = Order.new
    @order_creator = OrderCreator.new(current_user.cart, @order, cookies[:product_id], cookies[:quantity].to_i)
    remove_cookies unless cookies[:product_id].nil? || cookies[:product_id].empty?
    @cart_items = @order_creator.cart_items
    @total_price = @order_creator.total_price
  end

  def create
    @order = Order.new(order_params.except(:product_id, :quantity))
    @order_creator = OrderCreator.new(current_user.cart, @order, params[:order][:product_id], params[:order][:quantity])
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

  private

  def order_params
    params.require(:order).permit(:user_id, :shop_id, :address, :phone, :total_price, :product_id, :quantity)
  end
end
