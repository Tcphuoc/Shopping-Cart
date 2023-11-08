# frozen_string_literal: true

class CartsController < UsersController
  before_action :create_cart_creator, only: [:new, :update]
  before_action :find_cart, only: [:index]

  def index
  end

  def new
    respond_to do |format|
      format.json { render json: @cart_creator.response }
    end
  end

  def update
    @cart_creator.update_cart if @cart_creator.update_cart_valid?
    redirect_to request.referrer
  end

  protected

  def find_cart
    return @cart = current_user.cart if current_user

    @cart = Cart.new(user_id: nil, total_price: 0)
  end

  def cart_params
    params.require(:cart).permit(:product_id, :quantity)
  end

  def create_cart_creator
    product_id = params[:cart][:product_id]
    quantity = params[:cart][:quantity].to_i

    if params[:cart][:buy_now]
      cookies[:product_id] = product_id
      cookies[:quantity] = quantity
      buy_now = true
    else
      buy_now = false
    end

    @cart_creator = CartCreator.new(product_id, quantity, current_user.cart, buy_now)
  end
end
