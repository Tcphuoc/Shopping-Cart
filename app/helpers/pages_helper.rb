# frozen_string_literal: true

module PagesHelper
  def categories
    Category.all
  end
end
