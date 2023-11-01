# frozen_string_literal: true

module OrdersHelper
  def display_time(time)
    time.strftime('%H:%M:%S')
  end

  def display_date(date)
    date.strftime('%d/%m/%Y')
  end
end
