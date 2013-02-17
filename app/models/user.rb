class User < ActiveRecord::Base
  has_many :ratings
  has_many :comments
  validates_presence_of :ip
end
