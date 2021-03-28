class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :friends
  has_many :notifications


  has_many :ownedOrders, :class_name => "Order", :foreign_key => 'user_id'
  has_many :user_order_joins
  has_many :orders, through: :user_order_joins
  has_many :orders
  has_many :members;
  has_many :user_order_joins
  has_many :order_details
  has_many :groups, through: :members
  devise :database_authenticatable,
         :registerable, :recoverable,
         :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

         def self.from_omniauth(auth)
          # abort auth.inspect
          where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
              
              # binding.pry
              user.email = auth.info.email
              user.password = Devise.friendly_token[0, 20]
              user.full_name = auth.info.name
              # user.last_name = auth.info.name   
              # user.image = auth.info.image 
              # skiping eamil confirmation when use the providers  
              # user.skip_confirmation!
              user.save!
          end
        end
end
