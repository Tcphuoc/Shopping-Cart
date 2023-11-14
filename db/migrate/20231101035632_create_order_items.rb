class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.integer :product_id, null: false
      t.integer :order_id,   null: false
      t.string  :name,       null: false
      t.integer :price,      null: false
      t.integer :quantity,   null: false

      t.timestamps
    end
    add_index :order_items, :product_id
    add_index :order_items, :order_id
    add_index :order_items, [:product_id, :order_id]
  end
end
