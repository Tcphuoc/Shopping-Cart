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

  def cart_items_positve?
    @cart.cart_items.count.positive?
  end

  def save
    if @quantity || cart_items_positve?
      @order.save
      create_items
      send_email
      return true
    end

    false
  end

  def create_order_item(product_id, product, quantity)
    param = {
      product_id: product_id,
      order_id: @order.id,
      name: product.name,
      price: product.price,
      quantity: quantity
    }
    @order.order_items.create(param)
    update_stock(product_id, quantity)
  end

  def update_stock(product_id, quantity)
    product = Product.find_by(id: product_id)
    product.update_stock(-quantity.to_i)
  end

  def create_items
    if @product
      create_order_item(@product.id, @product, @quantity)
    else
      @cart.cart_items.each { |item| create_order_item(item.product_id, item, item.quantity) }
    end
    @cart.remove_all_items
  end

  def send_email
    OrderMailer.confirm_order(@order, @user).deliver_now
    OrderMailer.notify_order(@order, @shop, @user).deliver_now
  end

  def cart_items
    if @product
      return [CartItem.create(product_id: @product.id, name: @product.name, price: @product.price, quantity: @quantity)]
    end

    @cart.cart_items
  end

  def total_price
    return @cart.total_price if cart_items_positve?

    @quantity * @product.price
  end
end
