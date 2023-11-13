class AddImagesToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_column :order_items, :image1, :string
    add_column :order_items, :image2, :string
    add_column :order_items, :image3, :string
    add_column :order_items, :image4, :string
  end
end
