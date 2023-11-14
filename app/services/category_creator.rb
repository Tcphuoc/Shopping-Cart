# frozen_string_literal: true

class CategoryCreator
  attr_reader :category

  def initialize(params)
    @params = params
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
    categories = Category.where('slug LIKE ?', slug)
    !categories.empty?
  end

  def last_char_is_int?(slug)
    slug.last.to_i.to_s == slug.last
  end

  def save
    convert_slug
    @category = Category.new(@params)
    @category.save
  end
end
