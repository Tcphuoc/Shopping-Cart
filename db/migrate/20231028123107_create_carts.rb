class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.integer :user_id,     null: false
      t.integer :total_price, null: false

      t.timestamps
    end
    add_index :carts, :user_id, unique: true
  end
end
