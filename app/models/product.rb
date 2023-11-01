# frozen_string_literal: true

class Product < ApplicationRecord
  has_and_belongs_to_many :categories
  has_one_attached :image do |attachable|
    attachable.variant :thumb_smaller, resize_to_limit: [100, 100]
    attachable.variant :thumb, resize_to_limit: [200, 200]
    attachable.variant :thumb_larger, resize_to_limit: [500, 500]
  end
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items

  validates :name, presence: true
  validates :description, presence: true
  validates :stock, presence: true
  validates :price, presence: true
  validates :slug, presence: true, uniqueness: true

  def add_category(category)
    categories << category
  end

  def add_categories(category_ids)
    find_category_by_id(category_ids).each { |category| add_category(category) }
  end

  def update_category(category_ids)
    self.categories = find_category_by_id(category_ids)
  end

  def find_category_by_id(category_ids)
    category_ids.delete('')
    category_ids.map{ |id| Category.find_by(id: id) }
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

  def slug_name
    slug
  end
end
