# frozen_string_literal: true

module ProductsHelper
  def display_price(price)
    "#{number_with_delimiter(price, delimeter: ',')} VND"
  end

  def display_sold(product_id)
    OrderItem.where(product_id: product_id).reduce(0) do |solds, item|
      solds += item.quantity
      solds
    end
  end

  def all_images(product)
    images = []
    images << product.image1 unless product.image1.file.nil?
    images << product.image2 unless product.image2.file.nil?
    images << product.image3 unless product.image3.file.nil?
    images << product.image4 unless product.image4.file.nil?
    images
  end
end
