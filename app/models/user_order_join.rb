class UserOrderJoin < ApplicationRecord
    belongs_to :user
    belongs_to :order
    has_one :order_detail
end
