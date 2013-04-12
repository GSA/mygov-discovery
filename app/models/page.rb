class Page < ActiveRecord::Base
  require 'digest/md5'
  belongs_to :domain
  has_many :ratings
  has_many :comments
  acts_as_taggable

  validates_presence_of :path, :domain_id, :url_hash
  validates_uniqueness_of :path, :scope => :domain_id
  validates_uniqueness_of :url_hash

  before_validation :set_path, :associate_domain, :generate_hash, :make_pg13
  after_save :enqueue, :if => :url_hash_changed?
  
  attr_accessible :url, :tag_list, :title, :body

  searchable :if => :body do
    text :title
    text :body, :more_like_this => true
    string :domain do
      self.host
    end
  end
  
  class << self
    
    def hash_url(url)
      if url
        parts = Addressable::URI.parse(PostRank::URI.clean(url))
        Digest::MD5.hexdigest "http://#{parts.host}#{parts.path}"
      else
        nil
      end
    end    
  end
  
  def url=(url)
    @url = PostRank::URI.clean url
  end
  
  def url
    @url || "http://#{self.host}#{self.path}"
  end
  
  def host
    self.domain.hostname
  end
    
  def as_json(options={ :related => 0, :tags => 1})
    json = {:id => self.id, :url => self.url, :domain => self.domain, :path => self.path, :title => title, :avg_rating => avg_rating, :num_rating => self.ratings.count }
    json.merge!({:tags => self.tags, :tag_list => self.tag_list.to_s }) if options[:tags]
    json.merge!({:related => find_related_tags.slice(0,options[:related])}) if options[:related]
    json
  end
  
  def enqueue
    Resque.enqueue(PageScraper, self.id)
  end
  
  def scrape
    doc = strip_text(self.url)
    self.title = doc.title
    self.body = doc.body
    self.tag_list = Hash[doc.keywords].keys
    self.save
  end
  
  def rating_for_user(user)
    self.ratings.find_by_user_id(user.id)
  end
  
  def all_full_messages
    self.domain.errors.full_messages + self.errors.full_messages
  end
  
  private

  def parts
    url ? Addressable::URI.parse(url) : nil
  end
  
  def set_path
    self.path = parts.path
  end
  
  def associate_domain
    self.domain = Domain.find_by_hostname_hash(Domain.hash_domain(parts.host)) || Domain.create(:hostname => parts.host)
  end
  
  def generate_hash
    self.url_hash = Page.hash_url(url)
  end
      
  def make_pg13
    ProfanityFilter::Base.replacement_text = ""
    self.tag_list = ProfanityFilter::Base.clean self.tag_list.to_s
  end
  
  def strip_text(url)
    doc = Nokogiri::HTML(file)
    title = doc.xpath("//title").first.content.squish.truncate(TRUNCATED_TITLE_LENGTH, :separator => " ") rescue nil
    doc.css('script').each(&:remove)
    doc.css('style').each(&:remove)
    body = extract_body_from(doc)
  end
  
  def extract_body_from(doc)
    remove_common_substrings(scrub_inner_text(Sanitize.clean(nokogiri_doc.at('body').inner_html.encode('utf-8')))) rescue ''
  end
end
