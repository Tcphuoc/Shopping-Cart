# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart = find_cart
  end

  def new
    cart_creator = if params[:buy_now]
                     cookies[:product_id] = params[:product_id]
                     cookies[:quantity] = params[:quantity]
                     CartCreator.new(params[:product_id], params[:quantity].to_i, current_user.cart, true)
                   else
                     CartCreator.new(params[:product_id], params[:quantity].to_i, current_user.cart, false)
                   end

    respond_to do |format|
      format.json { render json: cart_creator.response }
    end
  end

  def update
    cart_creator = CartCreator.new(params[:cart][:product_id], params[:cart][:quantity].to_i, current_user.cart, false)
    cart_creator.update_cart if cart_creator.update_cart_valid?
    redirect_to request.referrer
  end

  protected

  def cart_params
    params.require(:cart).permit(:product_id, :quantity)
  end
end
