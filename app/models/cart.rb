class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :products, through: :cart_items

  def update_total_price(subtotal)
    new_value = total_price + subtotal
    update(total_price: new_value)
  end

  def update_cart_item(item)
    update_total_price(item[:price] * item[:quantity])
    if include?(item[:product_id])
      cart_item = cart_items.where(product_id: item[:product_id]).first
      cart_item.update(quantity: item[:quantity] + cart_item.quantity)
      remove_item(cart_item) if cart_item.quantity <= 0
    else
      cart_items.create(item)
    end
  end

  def remove_item(cart_item)
    cart_items.delete(cart_item)
  end

  def remove_all_items
    cart_items.delete_all
    update(total_price: 0)
  end

  def include?(product_id)
    product_ids.include? product_id
  end

  def add_more_item(product_id, quantity)
    cart_items.where('product_id = id', id: product_id).update(quantity: quantity)
  end
end
