# frozen_string_literal: true

class Admin::OrdersController < Admin::BaseController
  def index
    @orders = current_shop.orders.page(params[:page]).per(5)
  end
end
