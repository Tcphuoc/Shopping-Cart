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

  def valid?
    image_valid? && @product.valid?
  end

  def save
    @product.save
  end

  def update
    @product.update(@params)
  end

  def return_product
    @product
  end
end
