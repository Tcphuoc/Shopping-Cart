class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :shop_id

      t.timestamps
    end
    add_index :categories, :name
    add_index :categories, [:name, :shop_id], unique: true
  end
end
