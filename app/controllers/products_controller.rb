class ProductsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @products = Shop.first.products
  end

  def show
    @product = Product.find(params[:id])
    @cart = find_cart
  end
end
