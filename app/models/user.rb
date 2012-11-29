class User < ActiveRecord::Base

  devise :omniauthable, :token_authenticatable

  has_many :ratings
  
end
