# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_shop!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    if shop_signed_in?
      @products = Product.all.page(params[:page]).per(10)
      render 'products/index_shop'
    else
      @products = Product.all.page(params[:page]).per(8)
      render 'products/index_user'
    end
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.new(product_params)
    if product.save
      product.add_categories(params[:product][:categories])
      flash[:notice] = 'Create product success'
      redirect_to products_url
    else
      flash[:alert] = 'Create product fail. Please try again'
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @cart = find_cart
  end

  def edit
  end

  def update
    if @product.update(product_params)
      @product.update_category(params[:product][:categories])
      flash[:notice] = 'Update product success'
      redirect_to products_url
    else
      flash.now[:alert] = 'Update product fail. Please try again'
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    flash[:notice] = 'Delete product success'
    redirect_to products_url
  end

  private

  def find_product
    @product = Product.find_by(slug: params[:slug])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :image, :slug)
  end
end
