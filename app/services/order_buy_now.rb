# frozen_string_literal: true

class OrderBuyNow
  attr_reader :product, :quantity, :items

  def initialize(input)
    @order = input[:order]
    @product = find_product(input[:product_id])
    @quantity = input[:quantity]
    @items = nil
  end

  def find_product(id)
    Product.find_by(id: id)
  end

  def items_valid?
    @product.stock >= @quantity
  end

  def items_empty?
    @product.nil?
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
      create_order_item
      send_email
      return true
    end

    false
  end

  def create_order_item
    param = {
      product_id: @product.id,
      order_id: @order.id,
      name: @product.name,
      price: @product.price,
      quantity: @quantity
    }
    @order.order_items.create(param)
    product.update_stock(-@quantity.to_i)
  end

  def total_price
    @product.price * @quantity
  end

  def send_email
    shop = Shop.find_by(id: @order.shop_id)
    user = User.find_by(id: @order.user_id)
    OrderMailer.confirm_order(@order, user).deliver_now
    OrderMailer.notify_order(@order, shop, user).deliver_now
  end
end
