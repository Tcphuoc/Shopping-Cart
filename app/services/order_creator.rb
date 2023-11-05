# frozen_string_literal: true

class OrderCreator
  def initialize(cart, order, product_id, quantity)
    @cart = cart
    @order = order
    @shop = find_shop(order.shop_id)
    @user = find_user(order.user_id)
    @product = find_product(product_id)
    @quantity = quantity
  end

  def find_shop(id)
    Shop.find_by(id: id)
  end

  def find_user(id)
    User.find_by(id: id)
  end

  def find_product(id)
    Product.find_by(id: id)
  end

  def save
    if @quantity || @cart.cart_items.count.positive?
      @order.save
      create_order_items
      send_email
      true
    else
      false
    end
  end

  def create_order_items
    if @product
      param = {
        product_id: @product.id,
        order_id: @order.id,
        name: @product.name,
        price: @product.price,
        quantity: @quantity
      }
      @order.order_items.create(param)
    else
      @cart.cart_items.each do |item|
        param = {
          product_id: item.product_id,
          order_id: @order.id,
          name: item.name,
          price: item.price,
          quantity: item.quantity
        }
        @order.order_items.create(param)
      end
      @cart.remove_all_items
    end
  end

  def send_email
    OrderMailer.confirm_order(@order, @user).deliver_now
    OrderMailer.notify_order(@order, @shop, @user).deliver_now
  end
end
