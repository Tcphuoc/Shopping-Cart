# frozen_string_literal: true

class Admin::ProductsController < Admin::BaseController
  before_action :find_product, only: [:show, :edit, :destroy]
  before_action :find_by_old_slug, only: [:update]

  def index
    @products = Product.all.page(params[:page]).per(10)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = 'Create product success'
      redirect_to admin_products_url
    else
      flash.now[:alert] = 'Create product fail. Please try again'
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params.except(:old_slug))
      flash[:notice] = 'Update product success'
      redirect_to admin_products_url
    else
      @product.slug = product_params[:old_slug]
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

  def find_by_old_slug
    @product = Product.find_by(slug: params[:product][:old_slug])
  end

  def product_params
    params.require(:product).permit(:shop_id, :name, :description, :price, :stock, :slug, :old_slug, :category_id,
                                    :image1, :image2, :image3, :image4)
  end
end
