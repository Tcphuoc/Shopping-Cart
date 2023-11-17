# frozen_string_literal: true

class FilterService
  def initialize(params)
    @name = convert_type(params[:name])
    @slug = convert_type(params[:slug])
    @min_price = find_min_price(params[:min_price])
    @max_price = find_max_price(params[:max_price])
    @min_stock = find_min_stock(params[:min_stock])
    @max_stock = find_max_stock(params[:max_stock])
  end

  def convert_type(param)
    "%#{param}%"
  end

  def find_max_price(number)
    if number == ''
      Product.maximum('price')
    else
      number.to_i
    end
  end

  def find_min_price(number)
    if number == ''
      Product.minimum('price')
    else
      number.to_i
    end
  end

  def find_max_stock(number)
    if number == ''
      Product.maximum('stock')
    else
      number.to_i
    end
  end

  def find_min_stock(number)
    if number == ''
      Product.minimum('stock')
    else
      number.to_i
    end
  end

  def products
    Product.where('name LIKE ?', @name)
           .and(Product.where('slug LIKE ?', @slug))
           .and(Product.where('price >= ? AND price <= ?', @min_price, @max_price))
           .and(Product.where('stock >= ? AND stock <= ?', @min_stock, @max_stock))
  end

  def categories
    Category.where('name LIKE ? AND slug LIKE ?', @name, @slug)
  end
end
