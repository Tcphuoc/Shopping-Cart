# frozen_string_literal: true

class CartCreator
  def initialize(id, quantity)
    @product = find_product(id)
    @quantity = quantity
  end

  def find_product(id)
    Product.find_by(id: id)
  end

  def valid?
    @product.stock >= @quantity && @quantity != 0
  end

  def update_cart(cart)
    item = { product_id: @product.id, name: @product.name, price: @product.price, quantity: @quantity }

    cart.update_cart_item(item)
    @product.update_stock(-@quantity)
  end
end
