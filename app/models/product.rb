class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  has_one_attached :image do |attachable|
    attachable.variant :thumb_smaller, resize_to_limit: [100, 100]
    attachable.variant :thumb, resize_to_limit: [250, 250]
    attachable.variant :thumb_larger, resize_to_limit: [500, 500]
  end
  has_many :cart_items
  has_many :carts, through: :cart_items

  def add_category(category)
    categories << category
  end

  def category?(category)
    categories.include?(category)
  end

  def remove_category(category)
    categories.delete(category)
  end

  def update_stock(quantity)
    new_value = stock + quantity
    update(stock: new_value)
  end
end
