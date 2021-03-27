class Group < ApplicationRecord

  has_many :members
  has_many :users, through: :members , dependent: :delete_all
end
