class Scrape
  @queue = :scraper_queue
  
  def self.perform(page_id)
    page = Page.find(page_id)
    page.scrape
  end
end