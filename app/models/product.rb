# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  has_many_attached :images do |attachable|
    attachable.variant :thumb_smaller, resize_to_limit: [100, 100]
    attachable.variant :thumb, resize_to_limit: [250, 250]
    attachable.variant :thumb_larger, resize_to_limit: [400, 400]
  end
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :stock, comparison: { greater_than_or_equal_to: 0 }
  validates :price, comparison: { greater_than: 1000 }
  validates :slug, presence: true, uniqueness: true

  def update_stock(quantity)
    new_value = stock + quantity
    update(stock: new_value)
  end

  def slug_name
    slug
  end
end
