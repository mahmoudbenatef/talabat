class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :friends
  has_many :orders, through: :user_order_joins
  has_many:orders
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
