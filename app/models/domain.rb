class Domain < ActiveRecord::Base
  require 'digest/md5'

  has_many :pages
  attr_accessible :hostname
  validates_uniqueness_of :hostname
  validates_presence_of :hostname, :md5
  
  before_validation :build_hash
  
  def build_hash( hostname = self.hostname )
    self.md5 = Digest::MD5.hexdigest( hostname ) unless hostname.nil?
  end
  
end
