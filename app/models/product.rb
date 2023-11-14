# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  has_many :carts, through: :cart_items

  mount_uploader :image1, ImageUploader
  mount_uploader :image2, ImageUploader
  mount_uploader :image3, ImageUploader
  mount_uploader :image4, ImageUploader

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :stock, comparison: { greater_than_or_equal_to: 0 }
  validates :price, comparison: { greater_than: 1000 }
  validates :slug, presence: true, uniqueness: true
  validate :validate_image

  def update_stock(quantity)
    new_value = stock + quantity
    update(stock: new_value)
  end

  def slug_name
    slug
  end

  def category?(category)
    self.category == category
  end

  def validate_image
    errors.add(:image1, "can't be empty") if image1.file.nil?
  end
end
