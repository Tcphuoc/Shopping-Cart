# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :find_product, only: [:show]
  before_action :find_cart, only: [:show]

  def index
    if params[:filter]
      filter = FilterService.new(filter_params)
      products = Kaminari.paginate_array(filter.products)
    else
      products = Product.all
    end
    @products = products.page(params[:page]).per(8)
  end

  def show
  end

  private

  def find_product
    @product = Product.find_by!(slug: params[:slug])
  end

  def find_cart
    return @cart = current_user.cart if current_user

    @cart = Cart.new(user_id: nil, total_price: 0)
  end

  def filter_params
    params.permit(:name, :slug, :min_price, :max_price, :min_stock, :max_stock, :filter)
  end
end
