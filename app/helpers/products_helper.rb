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
end
