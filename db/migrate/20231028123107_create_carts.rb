class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.integer :user_id, null: true
      t.integer :total_price

      t.timestamps
    end
  end
end
