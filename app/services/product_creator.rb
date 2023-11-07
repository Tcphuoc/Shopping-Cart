# frozen_string_literal: true

class ProductCreator
  def initialize(params)
    @images = params[:images].count
    @product = new_product(params)
  end

  def new_product(params)
    Product.new(
      name: params[:name],
      description: params[:description],
      price: params[:price],
      stock: params[:stock],
      slug: params[:slug],
      category_id: params[:category].to_i,
      images: params[:images]
    )
  end

  def image_valid?
    if @images > 4
      @product.errors.add(:images, "Images can't be greater than 4 images")
      return false
    end
    true
  end

  def valid?
    image_valid? && @product.valid?
  end

  def save
    @product.save
  end

  def return_product
    @product
  end
end
