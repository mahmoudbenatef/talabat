class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.string :item_name
      t.integer :amount
      t.float :price
      t.text :comment

      t.timestamps
    end
  end
end
