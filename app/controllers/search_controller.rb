# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    temp = if params[:search].empty?
             Product.all
           else
             Product.where('name LIKE ?', "%#{params[:search]}%")
           end
    @products = temp.page(params[:page]).per(12)
  end
end
