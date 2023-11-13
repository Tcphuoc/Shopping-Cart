# frozen_string_literal: true

class Admin::FilterController < Admin::BaseController
  def filter_product
    filter = Filter.new(params)
    @products = Kaminari.paginate_array(filter.products).page(params[:page]).per(10)
    render 'admin/products/index', status: :unprocessable_entity
  end

  def filter_category
    filter = Filter.new(params)
    @categories = Kaminari.paginate_array(filter.categories).page(params[:page]).per(10)
    render 'admin/categories/index', status: :unprocessable_entity
  end
end
