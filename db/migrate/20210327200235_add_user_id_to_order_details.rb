class AddUserIdToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    add_reference :order_details, :user, null: false, foreign_key: true
  end
end
