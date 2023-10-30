class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.integer :product_id
      t.integer :cart_id
      t.string :name
      t.integer :price
      t.integer :quantity

      t.timestamps
    end
  end
end
