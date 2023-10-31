# frozen_string_literal: true

module CartsHelper
  def find_cart
    return current_user.cart if current_user

    Cart.new(user_id: nil, total_price: 0)
  end
end
