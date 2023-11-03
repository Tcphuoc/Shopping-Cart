# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  has_many :order_items
  validates :phone, presence: true, format: { with: REGEX_PHONE_NUMBER }
  validates :address, presence: true
  validates :status, inclusion: { in: [1, 2, 3] }
  validates :order_items, presence: true, unless: :order_items_empty?

  def order_items_empty?
    order_items.count < 1
  end
end
