# frozen_string_literal: true

class Category < ApplicationRecord
  has_and_belongs_to_many :products
  validates :name, presence: true, length: { maximum: 20 }
  validates :slug, presence: true, length: { maximum: 20 }, uniqueness: true

  before_save :convert_slug
  before_update :convert_slug

  private

  def convert_slug
    self.slug = I18n.transliterate(slug.downcase).parameterize(separator: '_')
  end
end
