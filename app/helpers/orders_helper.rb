# frozen_string_literal: true

module OrdersHelper
  def display_time(time)
    time.strftime('%H:%M:%S')
  end

  def display_date(date)
    date.strftime('%d/%m/%Y')
  end

  def find_user_by_id(id)
    User.find_by(id: id)
  end

  def remove_cookies
    cookies[:product_id] = nil
    cookies[:quantity] = nil
  end
end
