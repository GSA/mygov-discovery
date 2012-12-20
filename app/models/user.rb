class User < ActiveRecord::Base

  #arbitrary user model to serve as a placeholder for now
  # eventually, we'd want to map this to MyGov accounts, API Keys, etc.

  has_many :ratings
  has_many :comments
  
end
