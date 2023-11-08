class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.integer :shop_id
      t.integer :category_id
      t.string :name
      t.string :description
      t.integer :price
      t.integer :stock

      t.timestamps
    end
    add_index :products, :name
    add_index :products, [:shop_id, :category_id, :name], unique: true
  end
end
