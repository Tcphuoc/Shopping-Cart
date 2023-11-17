# frozen_string_literal: true

class ProductCreatorService
  attr_reader :product

  def initialize(params)
    @params = params
  end

  def find_product(slug)
    @product = Product.find_by(slug: slug)
  end

  def convert_slug
    return if !@params[:slug].empty? || @params[:name].empty?

    string = @params[:name].titleize.downcase
    slug = string.parameterize(separator: '_')
    while slug_exist?(slug)
      temp = string.chars

      if last_char_is_int?(slug)
        temp[-1] = (temp[-1].to_i + 1).to_s
      else
        temp << '1' unless last_char_is_int?(slug)
      end

      string = temp.join
      slug = string.parameterize(separator: '_')
    end
    @params[:slug] = slug
  end

  def slug_exist?(slug)
    products = Product.where('slug LIKE ?', slug)
    !products.empty?
  end

  def last_char_is_int?(slug)
    slug.last.to_i.to_s == slug.last
  end

  def save
    convert_slug
    @product = Product.new(@params)
    @product.save
  end

  def update
    find_product(@params[:old_slug])
    @product.remove_image2! if @params[:remove_image2] == 'true'
    @product.remove_image3! if @params[:remove_image3] == 'true'
    @product.remove_image4! if @params[:remove_image4] == 'true'
    @product.update(@params.except(:remove_image2, :remove_image3, :remove_image4, :old_slug))
  end
end
