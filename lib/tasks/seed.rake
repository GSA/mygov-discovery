require 'open-uri'
require 'json'
require 'postrank-uri'
require 'nokogiri'

$data_url = 'https://explore.data.gov/api/views/deuw-vn8r/rows.json?accessType=DOWNLOAD'

class Crawl
  @queue = :crawler_queue
  
  def self.perform(url)
    links = self.crawl url
    for link in links do
       puts "Adding page " + link
       Page.create :url => link
    end
  end
  
  def self.crawl(url)
    parts = Addressable::URI.parse url
    url = parts.scheme + "://" + parts.host
    url = PostRank::URI.clean url
    doc = Nokogiri::HTML(open(url))
    @url = url
    links = doc.css 'a'
    links.map {|link| PostRank::URI.clean link.attribute('href').to_s }.uniq.delete_if {|link| link.empty?}.delete_if{ |link| !link.start_with? @url }
  end
  
end

task :seed do
  
  domains = []
  json =  JSON.parse open($data_url).read
  
  for row in json["data"] do
    url = PostRank::URI.clean row[8][0]
    puts "Adding domain " + url
    Resque.enqueue(Crawl, url)
  end
  
end