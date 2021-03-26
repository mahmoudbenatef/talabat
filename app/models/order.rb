class Order < ApplicationRecord
    belongs_to :user, :class_name => "User",:optional => true
    has_many :users, through: :user_order_joins
end
