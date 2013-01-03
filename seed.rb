require 'open-uri'
require 'json'
require 'postrank-uri'
require 'nokogiri'

$data_url = 'https://explore.data.gov/api/views/deuw-vn8r/rows.json?accessType=DOWNLOAD'

class Crawl
  @queue = :crawler_queue
  
  def self.perform(url)
    links = crawl url
    for link in links do
       Page.create :url => url
    end
  end
  
  def crawl(url)
    parts = Addressable::URI.parse url
    url = parts.scheme + "://" + parts.host
    url = PostRank::URI.clean url
    doc = Nokogiri::HTML(open(url))
    @url = url
    links = doc.css 'a'
    links.map {|link| PostRank::URI.clean link.attribute('href').to_s }.uniq.delete_if {|link| link.empty?}.delete_if{ |link| !link.start_with? @url }
  end
  
end

def get_domains
  
  domains = []
  json =  JSON.parse open($data_url).read
  
  for row in json["data"] do
    url = PostRank::URI.clean row[8][0]
    Resque.enqueue(Crawl, url)
  end
  
end

get_domains()