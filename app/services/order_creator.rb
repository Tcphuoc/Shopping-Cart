# frozen_string_literal: true

class OrderCreator
  def initialize(cart, order)
    @cart = cart
    @order = order
    @shop = find_shop(order.shop_id)
    @user = find_user(order.user_id)
  end

  def find_shop(id)
    Shop.find_by(id: id)
  end

  def find_user(id)
    User.find_by(id: id)
  end

  def create_order_items
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

  def send_email
    OrderMailer.confirm_order(@order, @user).deliver_now
    OrderMailer.notify_order(@order, @shop, @user).deliver_now
  end
end
