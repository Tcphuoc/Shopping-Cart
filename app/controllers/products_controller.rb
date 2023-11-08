# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :find_product, only: [:show]
  before_action :find_cart, only: [:show]

  def index
    @products = Product.all.page(params[:page]).per(8)
  end

  def show
    redirect_to root_url if @product.nil?
  end

  private

  def find_product
    @product = Product.find_by(slug: params[:slug])
  end

  def find_cart
    return @cart = current_user.cart if current_user

    @cart = Cart.new(user_id: nil, total_price: 0)
  end
end
