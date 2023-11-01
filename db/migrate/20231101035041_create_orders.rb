class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :shop_id
      t.integer :status
      t.string :address
      t.string :phone
      t.integer :total_price

      t.timestamps
    end
  end
end
