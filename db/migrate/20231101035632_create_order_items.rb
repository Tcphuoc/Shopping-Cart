class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.integer :product_id
      t.integer :order_id
      t.string :name
      t.integer :price
      t.integer :quantity

      t.timestamps
    end
    add_index :order_items, :product_id
    add_index :order_items, :order_id
    add_index :order_items, [:product_id, :order_id]
  end
end
