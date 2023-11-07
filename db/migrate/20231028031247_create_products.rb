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
  end
end
