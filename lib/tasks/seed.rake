require 'open-uri'
require 'json'
require 'postrank-uri'
require 'nokogiri'

namespace :myusa do
  namespace :discovery do
    task :seed do
      data_url = 'https://explore.data.gov/api/views/deuw-vn8r/rows.json?accessType=DOWNLOAD'
      domains = []
      json =  JSON.parse(open(data_url).read)
  
      for row in json["data"] do
        url = PostRank::URI.clean row[8][0]
        puts "Adding domain " + url
        Resque.enqueue(PageCrawler, url)
      end
    end
  end
end