class AddOwnerIdToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :owner_id, :integer
    add_index :orders, :owner_id
  end
end
