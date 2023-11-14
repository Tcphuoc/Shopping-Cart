class AddSlugToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :slug, :string, null: false, unique: true
  end
end
