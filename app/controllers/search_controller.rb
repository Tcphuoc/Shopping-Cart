# frozen_string_literal: true

class SearchController < ApplicationController
  before_action :find_products_by_id, only: [:index]

  def index
    @products = Kaminari.paginate_array(@products).page(params[:page]).per(12)
  end

  def search
    session[:results] = if params[:search].empty?
                          Product.ids
                        else
                          Product.where('name LIKE ?', "%#{params[:search]}%").ids
                        end
    redirect_to search_index_url
  end

  private

  def find_products_by_id
    product_ids = session[:results]
    @products = product_ids.map { |id| Product.find(id) }
  end
end
