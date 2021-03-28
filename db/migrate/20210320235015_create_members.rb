class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.belongs_to :group
      t.belongs_to :user

      t.timestamps
    end
    add_foreign_key :members, :groups, column: :group_id, primary_key: :id
    add_foreign_key :members, :users, column:  :user_id, primary_key: :id
  end
end
