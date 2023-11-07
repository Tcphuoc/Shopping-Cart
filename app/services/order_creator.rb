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
      create_items
      send_email
      true
    else
      false
    end
  end

  def cart_item_param(product, quantity)
    {
      product_id: product.id,
      order_id: @order.id,
      name: product.name,
      price: product.price,
      quantity: quantity
    }
  end

  def create_items
    if @product
      @order.order_items.create(cart_item_param(@product, @quantity))
    else
      @cart.cart_items.each do |item|
        @order.order_items.create(cart_item_param(item, item.quantity))
        @cart.remove_all_items
      end
    end
  end

  def send_email
    OrderMailer.confirm_order(@order, @user).deliver_now
    OrderMailer.notify_order(@order, @shop, @user).deliver_now
  end
end
