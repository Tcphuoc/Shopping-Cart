# frozen_string_literal: true

class CartCreator
  attr_reader :cart

  def initialize(id, quantity, cart, buy_now)
    @product = find_product(id)
    @quantity = quantity
    @cart = cart
    @buy_now = buy_now
  end

  def find_product(id)
    Product.find_by(id: id)
  end

  def find_item(product_id)
    @cart.cart_items.where(product_id: product_id).first
  end

  def add_cart_valid?
    if check_stock && check_quantity
      @status = 'success'
      @message = 'Add to cart success'
    end
  end

  def update_cart_valid?
    if check_stock && @quantity != 0
      @status = 'success'
      @message = 'Add to cart success'
    end
  end

  def check_quantity
    return true if @quantity.positive?

    @status = 'fail'
    @message = 'Quantity must be greater than 0. Please try again'
    false
  end

  # Check stock is valid to add/update
  def check_stock
    if @cart.include?(@product.id)
      !out_of_stock?(@quantity + find_item(@product.id).quantity)
    else
      !out_of_stock?(@quantity)
    end
  end

  def out_of_stock?(quantity)
    if @product.stock < quantity
      @status = 'fail'
      @message = 'You buy products more than our stock. Please try again'
      return true
    end
    false
  end

  def update_cart
    item = { product_id: @product.id, quantity: @quantity }

    @cart.update_cart_item(item) unless @buy_now
  end

  def response
    return { status: 'redirect' } if @buy_now

    { status: @status, message: @message, items: quantity_items }
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
