class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.integer :shop_id,     null: false
      t.integer :category_id, null: false 
      t.string  :name,        null: false, unique: true
      t.string  :description, null: false
      t.integer :price,       null: false
      t.integer :stock,       null: false

      t.timestamps
    end
    add_index :products, :name, unique: true
    add_index :products, [:shop_id, :category_id, :name], unique: true
  end
end
