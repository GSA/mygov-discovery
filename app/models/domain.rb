class Domain < ActiveRecord::Base
  require 'digest/md5'
  has_many :pages, :order => 'avg_rating DESC'
  attr_accessor :hostname
  attr_accessible :hostname
  validates_format_of :hostname, :with => /.*\.(gov|mil|fed\.us|si\.edu)/i, :message => "Domain must be a .gov"
  validates_uniqueness_of :hostname_reversed
  validates_presence_of :hostname_reversed, :hostname_hash
  before_validation :generate_hash
  
  self.per_page = 25
  
  def hostname=(hostname)
    self.hostname_reversed = hostname.split('.').reverse.join('.') + '.'
  end
  
  def hostname
    self.hostname_reversed.split('.').reverse.join('.')
  end
  
  def as_json(options={ :pages => 0 })
    json = { :hostname => hostname, :hostname_hash => hostname_hash, :id => id }
    json = json.merge({ :pages => pages.as_json({:tags => false}) }) unless !options[:pages]
    json
  end
  
  private
  
  def generate_hash
    self.hostname_hash = Digest::MD5.hexdigest(self.hostname) unless self.hostname.nil?
  end
end
