class PageScraper
  @queue = :page_scraper_queue
  
  def self.perform(page_id)
    page = Page.find(page_id)
    page.scrape if page
  end
end