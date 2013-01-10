class Domain < ActiveRecord::Base
  require 'digest/md5'
  has_many :pages
  attr_accessor :hostname
  attr_accessible :hostname
  validates_uniqueness_of :hostname_reversed
  validates_presence_of :hostname_reversed, :hostname_hash
  validates_format_of :hostname, :with => /.*\.gov/i, :message => "Domain must be a .gov"
  before_validation :generate_hash
  
  def hostname=(hostname)
    self.hostname_reversed = hostname.split('.').reverse.join('.') + '.'
  end
  
  def hostname
    self.hostname_reversed.split('.').reverse.join('.')
  end
  
  def as_json(options={})
    { :hostname => hostname, :hostname_hash => hostname_hash, :id => id }
  end
  
  private
  
  def generate_hash
    self.hostname_hash = Digest::MD5.hexdigest(self.hostname) unless self.hostname.nil?
  end
end
