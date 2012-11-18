class Page < ActiveRecord::Base
  require 'digest/md5'
  
  attr_protected :domain_id, :path, :url_hash, :tags
  attr_accessible :url, :tag_list
  attr_accessor :url_hash, :parts, :domain, :path, :related
   
  belongs_to :domain
  acts_as_taggable
    
  validates_presence_of :path, :domain_id, :url_hash
  validates_uniqueness_of :path, :scope => :domain_id

  before_validation :parse_path  
  before_validation :assign_domain
  before_validation :build_hash 
  
  def url=(url)
    @url = PostRank::URI.clean( url )
  end
  
  def url
    @url = 'http://' + self.domain.hostname.to_s + self.path.to_s
  end
  
  def parts
    Addressable::URI.parse( @url ) unless @url.nil?
  end
  
  def domain
    domain = Domain.find( self.domain_id ) unless self.domain_id.nil?
    if domain.nil?
      hash = Digest::MD5.hexdigest( self.parts.host )
      domain = Domain.find_by_hostname_hash( hash )
      if domain.nil?
        domain = Domain.create({ :hostname => self.parts.host })
      end
    end
    domain
  end
  
  def path
    return read_attribute(:path) unless read_attribute(:path).nil?
    self.parts.path.to_s unless self.parts.nil?
  end
  
  def assign_domain
    self.domain_id = self.domain.id
  end
  
  def parse_path
    self.path = path();
  end
  
  def as_json(options={})
    { :id => self.id, :url => self.url(), :domain => self.domain(), :parts => self.parts(), :path => self.path(), :tags => self.tags, :related => self.find_related_tags, :tag_list => self.tag_list.to_s }
  end
  
  def build_hash(url=self.url)
     self.url_hash = Digest::MD5.hexdigest( url ) unless url.nil?
  end
  
end
