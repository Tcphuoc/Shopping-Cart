module ProductsHelper
  def display_price(price)
    "#{number_with_delimiter(price, delimeter: ',')} vnđ"
  end

  def all_products
    Product.all
  end
end
