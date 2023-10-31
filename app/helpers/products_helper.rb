# frozen_string_literal: true

module ProductsHelper
  def display_price(price)
    "#{number_with_delimiter(price, delimeter: ',')} VND"
  end
end
