# frozen_string_literal: true

class ProductCreator
  def initialize(params, product)
    @params = params
    @product = product
  end

  def image_valid?
    return true if @params[:images].count <= 5

    @product.errors.add(:images, "Images can't be greater than 4 images")
    false
  end

  def product_valid?
    @product.name = @params[:name]
    @product.slug = @params[:slug]
    @product.description = @params[:description]
    @product.price = @params[:price]
    @product.stock = @params[:stock]
    @product.category_id = @params[:category_id]
    @product.images = @params[:images]
    @product.valid?
  end

  def valid?
    image_valid? && product_valid?
  end

  def save
    @product.save
  end

  def return_product
    @product
  end
end
