# frozen_string_literal: true

class CartCreator
  def initialize(id, quantity, cart, buy_now)
    @product = find_product(id)
    @quantity = quantity
    @cart = cart
    @buy_now = buy_now
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

  def update_cart
    item = { product_id: @product.id, name: @product.name, price: @product.price, quantity: @quantity }

    @cart.update_cart_item(item)
    @product.update_stock(-@quantity)
  end

  def response
    return { status: 'fail', message: 'You buy products more than our stock. Please try again' } if out_of_stock?
    return { status: 'fail', message: 'Quantity must be greater than 0. Please try again' } unless add_cart_valid?

    if @buy_now
      { status: 'redirect' }
    else
      update_cart
      { status: 'success', message: 'Add to cart success', items: @cart.cart_items.count }
    end
  end
end
