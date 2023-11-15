# frozen_string_literal: true

class OrderAddCart
  attr_reader :product, :quantity

  def initialize(input)
    @cart = input[:cart]
    @order = input[:order]
    @product = nil
    @quantity = nil
  end

  def find_product(id)
    Product.find_by(id: id)
  end

  def items_valid?
    return false if items_empty? || @cart.total_price != total_price

    @cart.cart_items.each do |item|
      product = find_product(item.product_id)
      return false unless product.stock >= item.quantity && product.price == item.price && !product.nil?
    end
    true
  end

  def items_empty?
    reload_cart
    @cart.cart_items.empty?
  end

  def save
    if items_valid?
      return false unless order_save

      return true
    end
    false
  end

  def order_save
    if @order.save
      create_items
      send_email
      return true
    end

    false
  end

  def create_items
    items.each { |item| create_order_item(find_product(item.product_id), item.quantity) }
    @cart.remove_all_items
  end

  def create_order_item(product, quantity)
    param = {
      product_id: product.id,
      order_id: @order.id,
      name: product.name,
      price: product.price,
      quantity: quantity
    }
    @order.order_items.create(param)
    product.update_stock(-quantity.to_i)
  end

  def total_price
    @cart.cart_items.reduce(0) do |total, item|
      total += item.price * item.quantity
      total
    end
  end

  def reload_cart
    @cart.cart_items.each do |item|
      product = find_product(item.product_id)
      item.update(quantity: product.stock) if item.quantity > product.stock
      item.update(price: product.price) if item.price != product.price
      @cart.remove_item(item) if product.nil? || product.stock.zero?
    end
  end

  def items
    @cart.cart_items
  end

  def send_email
    shop = Shop.find_by(id: @order.shop_id)
    user = User.find_by(id: @order.user_id)
    OrderMailer.confirm_order(@order, user).deliver_now
    OrderMailer.notify_order(@order, shop, user).deliver_now
  end
end
