class AddSlugToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :slug, :string, null: false, unique: true
  end
end
