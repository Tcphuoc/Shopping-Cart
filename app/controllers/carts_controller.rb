# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart = find_cart
  end

  def new
    cart_creator = CartCreator.new(params[:product_id], params[:quantity].to_i)
    cart = current_user.cart
    if cart_creator.add_cart_valid?
      cart_creator.update_cart(cart)
      response = { status: 'success', message: 'Add to cart success', items: cart.cart_items.count }
    elsif cart_creator.out_of_stock?
      response = { status: 'fail', message: 'You buy products more than our stock. Please try again' }
    else
      response = { status: 'fail', message: 'Quantity must be greater than 0. Please try again' }
    end

    respond_to do |format|
      format.json { render json: response }
    end
  end

  def update
    cart_creator = CartCreator.new(params[:cart][:product_id], params[:cart][:quantity].to_i)
    cart = current_user.cart
    cart_creator.update_cart(cart) if cart_creator.update_cart_valid?
    redirect_to request.referrer
  end

  protected

  def cart_params
    params.require(:cart).permit(:product_id, :quantity)
  end
end
