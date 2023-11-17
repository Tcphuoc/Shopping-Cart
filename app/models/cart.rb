# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  has_many :products, through: :cart_items

  validates :user_id, presence: true
  validates :total_price, presence: true

  def remove_item(cart_item)
    cart_items.delete(cart_item)
    cart_item.destroy
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
