# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :find_category, only: [:show]

  def show
    @products = @category.products.page(params[:page]).per(8)
  end

  private

  def find_category
    @category = Category.find_by(slug: params[:slug])
  end
end
