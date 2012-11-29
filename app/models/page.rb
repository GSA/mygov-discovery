class Page < ActiveRecord::Base
  require 'digest/md5'

  attr_protected :domain_id, :path, :url_hash, :tags
  attr_accessible :url, :tag_list, :title, :rating
  attr_accessor :parts, :domain, :related
   
  belongs_to :domain
  has_many :ratings
  acts_as_taggable

  before_validation :parse_path, :build_hash, :assign_domain
    
  validates_presence_of :path, :domain_id, :url_hash
  validates_uniqueness_of :path, :scope => :domain_id
  validates_uniqueness_of :url_hash

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
  
  def as_json(options={ :related => false })
    json = { :id => self.id, :url => self.url(), :domain => self.domain(), :path => self.path(), :tags => self.tags, :tag_list => self.tag_list.to_s, :title => title }
    json = json.merge({ :related => find_related_tags }) unless !options[:related]
    json
  end
  
  def build_hash(url=self.url)
     self.url_hash = Digest::MD5.hexdigest( url )
  end
  
  def enqueue_scrape
  
    if self.id.nil?
      self.save
    end
    
    Resque.enqueue( Scrape, self.id )
    
  end
  
  def scrape
    
    doc = Pismo::Document.new( self.url )
    self.title = doc.title
    self.tag_list = Hash[doc.keywords].keys
    self.save

  end
  
end
