class PageCrawler
  @queue = :crawler_queue
  
  def self.perform(url)
    links = self.crawl(url)
    for link in links do
      Rails.logger.debug("Adding page #{link}")
      Page.create(:url => link)
    end
  end
  
  def self.crawl(url)
    parts = Addressable::URI.parse url
    page_url = PostRank::URI.clean parts.scheme + "://" + parts.host
    doc = Nokogiri::HTML(open(page_url))
    links = doc.css 'a'
    links.map {|link| PostRank::URI.clean link.attribute('href').to_s }.uniq.delete_if {|link| link.empty?}.delete_if{ |link| !link.start_with? @url }
  end
end