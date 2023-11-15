# frozen_string_literal: true

class Admin::ProductsController < Admin::BaseController
  before_action :find_product, only: [:show, :edit, :destroy]

  def index
    if params[:filter]
      filter = Filter.new(filter_params)
      products = Kaminari.paginate_array(filter.products)
    else
      products = Product.all
    end
    @products = products.page(params[:page]).per(10)
  end

  def new
    @product = Product.new
  end

  def create
    product_creator = ProductCreator.new(product_params)
    if product_creator.save
      flash[:notice] = 'Create product success'
      redirect_to admin_products_url
    else
      @product = product_creator.product
      flash.now[:alert] = 'Create product fail. Please try again'
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    product_creator = ProductCreator.new(product_params)
    if product_creator.update
      flash[:notice] = 'Update product success'
      redirect_to admin_products_url
    else
      @product = product_creator.return_product
      @product.slug = product_params[:old_slug]
      flash.now[:alert] = 'Update product fail. Please try again'
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    if exist_in_order?(@product.id)
      flash[:alert] = 'Delete product failed because product is being processed at an order'
    else
      @product.destroy
      flash[:notice] = 'Delete product success'
    end
    redirect_to admin_products_url
  end

  private

  def find_product
    @product = Product.find_by!(slug: params[:slug])
  end

  def exist_in_order?(id)
    Order.all.each do |order|
      order.order_items.each { |item| return true if item.product_id == id }
    end
    false
  end

  def product_params
    params.require(:product).permit(:shop_id, :name, :description, :price, :stock, :slug, :old_slug, :category_id,
                                    :image1, :image2, :image3, :image4, :remove_image2, :remove_image3, :remove_image4)
  end

  def filter_params
    params.permit(:name, :slug, :min_price, :max_price, :min_stock, :max_stock, :filter)
  end
end
