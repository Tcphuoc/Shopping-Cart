class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :user_id,     null: false
      t.integer :shop_id,     null: false
      t.string  :address,     null: false
      t.string  :phone,       null: false
      t.integer :total_price, null: false

      t.timestamps
    end
    add_index :orders, [:user_id, :shop_id]
  end
end
