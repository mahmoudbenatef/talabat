class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :friends
  has_and_belongs_to_many :order
  has_many:orders
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
         
      def self.from_omniauth(auth)
        abort auth.inspect
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            
            binding.pry
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
