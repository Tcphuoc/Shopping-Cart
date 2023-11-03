# frozen_string_literal: true

class CartCreator
  def initialize(id, quantity)
    @product = find_product(id)
    @quantity = quantity
  end

  def find_product(id)
    Product.find_by(id: id)
  end

  def add_cart_valid?
    !out_of_stock? && @quantity.positive?
  end

  def update_cart_valid?
    !out_of_stock? && @quantity != 0
  end

  def out_of_stock?
    @product.stock < @quantity
  end

  def update_cart(cart)
    item = { product_id: @product.id, name: @product.name, price: @product.price, quantity: @quantity }

    cart.update_cart_item(item)
    @product.update_stock(-@quantity)
  end
end
