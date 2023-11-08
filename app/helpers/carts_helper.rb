# frozen_string_literal: true

module CartsHelper
  def display_cart_items
    result = current_user.cart.cart_items.reduce(0) do |total, item|
      total += item.quantity
      total
    end
    return '10+' if result > 10

    result
  end
end
