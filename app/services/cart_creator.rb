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

  def find_cart_item(product_id)
    CartItem.find_by(product_id: product_id)
  end

  def add_cart_valid?
    !out_of_stock? && @quantity.positive?
  end

  def update_cart_valid?
    !out_of_stock? && @quantity != 0
  end

  def out_of_stock?
    @product.stock < if @cart.include?(@product.id)
                       (@quantity + find_cart_item(@product.id).quantity)
                     else
                       @quantity
                     end
  end

  def update_cart
    item = { product_id: @product.id, name: @product.name, price: @product.price, quantity: @quantity }

    @cart.update_cart_item(item)
  end

  def response
    return { status: 'fail', message: 'You buy products more than our stock. Please try again' } if out_of_stock?
    return { status: 'fail', message: 'Quantity must be greater than 0. Please try again' } unless add_cart_valid?

    if @buy_now
      { status: 'redirect' }
    else
      update_cart
      { status: 'success', message: 'Add to cart success', items: quantity_items }
    end
  end

  def quantity_items
    result = @cart.cart_items.reduce(0) do |total, item|
      total += item.quantity
      total
    end
    return '10+' if result > 10

    result
  end
end
