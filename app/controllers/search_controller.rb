# frozen_string_literal: true

class SearchController < UsersController
  def index
    temp = Product.where('name LIKE ?', "%#{params[:search]}%")
    if temp.empty?
      @empty = true
      temp = Product.all
    end
    @products = Kaminari.paginate_array(temp).page(params[:page]).per(8)
  end
end
