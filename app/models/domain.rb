class Domain < ActiveRecord::Base
  require 'digest/md5'

  has_many :pages
  attr_accessor :hostname
  attr_accessible :hostname
  validates_uniqueness_of :hostname_reversed
  validates_presence_of :hostname_reversed, :hostname_hash
  
  before_validation :build_hash
  
  def build_hash( hostname = self.hostname )
    self.hostname_hash = Digest::MD5.hexdigest( hostname ) unless hostname.nil?
  end
  
  def hostname=(hostname)
    self.hostname_reversed = hostname.split('.').reverse.join('.')
  end
  
  def hostname
    self.hostname_reversed.split('.').reverse.join('.')
  end
  
end
