# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :find_product, only: [:show]

  def index
    @products = Product.all.page(params[:page]).per(8)
  end

  def show
    @cart = find_cart
    redirect_to root_url if @product.nil?
  end

  private

  def find_product
    @product = Product.find_by(slug: params[:slug])
  end
end
