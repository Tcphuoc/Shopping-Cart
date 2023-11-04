class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :create_cart
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :first_name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :phone, presence: true, format: { with: REGEX_PHONE_NUMBER }
  validates :address, presence: true
  has_one :cart
  has_many :products, through: :cart
  has_many :orders

  def create_cart
    Cart.create(user_id: id, total_price: 0) if Cart.where(user_id: id).empty?
  end

  def create_order(param)
    order = Order.new(user_id: id, address: param[:address], phone: param[:phone])
    if order.save
      order.create_order_items(cart)
      true
    else
      false
    end
  end
end
