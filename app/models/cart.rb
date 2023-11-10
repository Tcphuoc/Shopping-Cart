# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :products, through: :cart_items

  validates :user_id, presence: true
  validates :total_price, presence: true

  def update_cart
    cart_items.each do |item|
      product = find_product(item.product_id)
      if product.stock.zero?
        remove_item(item)
      elsif product.stock <= item.quantity
        item.update(quantity: product.stock)
      end
    end
    update_total_price
  end

  def update_total_price
    new_value = cart_items.reduce(0) do |total, item|
      total += item.quantity * find_product(item[:product_id]).price
      total
    end
    update(total_price: new_value)
  end

  def update_cart_item(item)
    if include?(item[:product_id])
      cart_item = cart_items.where(product_id: item[:product_id]).first
      cart_item.update(quantity: item[:quantity] + cart_item.quantity)
      remove_item(cart_item) if cart_item.quantity <= 0
      update_total_price
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

  def find_product(id)
    Product.find(id)
  end
end
