class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart = find_cart
  end

  def update
    product = Product.find(params[:cart][:product_id])
    quantity = params[:cart][:quantity].to_i
    item = { product_id: product.id, name: product.name, price: product.price, quantity: quantity }
    if product.stock >= quantity
      current_user.cart.update_cart_item(item)
      product.update_stock(-quantity)
    end
    redirect_to request.referrer || root_url
  end

  protected

  def cart_params
    params.require(:cart).permit(:product_id, :quantity)
  end
end
