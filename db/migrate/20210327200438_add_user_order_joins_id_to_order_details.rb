class AddUserOrderJoinsIdToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    add_reference :order_details, :user_order_joins, null: false, foreign_key: true
  end
end
