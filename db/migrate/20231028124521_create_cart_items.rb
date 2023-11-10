class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.integer :product_id, null: false
      t.integer :cart_id
      t.integer :quantity,   null: false

      t.timestamps
    end
    add_index :cart_items, :product_id
    add_index :cart_items, [:product_id, :cart_id]
  end
end
