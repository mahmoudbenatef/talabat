class Group < ApplicationRecord
  has_many :users, through: :members , dependent: :delete_all
  has_many:members
end
