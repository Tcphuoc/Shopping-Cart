# frozen_string_literal: true

class Admin::ProductsController < Admin::BaseController
  before_action :find_product, only: [:show, :edit, :destroy]
  before_action :find_by_slug, only: [:update]

  def index
    @products = Product.all.page(params[:page]).per(10)
  end

  def new
    @product = Product.new
  end

  def create
    @product_creator = ProductCreator.new(product_params, Product.new(product_params))
    if @product_creator.valid?
      @product_creator.save
      flash[:notice] = 'Create product success'
      redirect_to admin_products_url
    else
      @product = @product_creator.return_product
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @product_creator = ProductCreator.new(product_params, @product)
    if @product_creator.valid?
      @product_creator.update
      flash[:notice] = 'Update product success'
      redirect_to admin_products_url
    else
      flash.now[:alert] = 'Update product fail. Please try again'
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    flash[:notice] = 'Delete product success'
    redirect_to admin_products_url
  end

  private

  def find_product
    @product = Product.find_by(slug: params[:slug])
  end

  def find_by_slug
    @product = Product.find_by(slug: params[:product][:slug])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :slug, :category_id, images: [])
  end
end
