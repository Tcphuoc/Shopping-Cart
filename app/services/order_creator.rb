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

  def create_items
    if @product
      create_order_item(@product, @quantity)
    else
      @cart.cart_items.each { |item| create_order_item(find_product(item.product_id), item.quantity) }
    end
    @cart.remove_all_items
  end

  def send_email
    OrderMailer.confirm_order(@order, @user).deliver_now
    OrderMailer.notify_order(@order, @shop, @user).deliver_now
  end

  def cart_items
    return [CartItem.create(product_id: @product.id, quantity: @quantity)] if @product

    @cart.cart_items
  end

  def total_price
    return @quantity * @product.price if @product

    @cart.total_price
  end

  def check_cart
    return @product.stock >= @quantity if @product

    @cart.cart_items.each do |item|
      product = find_product(item.product_id)
      return false if product.stock < item.quantity || product.price != item.price
    end
    true
  end
end
