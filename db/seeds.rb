Page.all.map(&:destroy)
Page.all.each { |page| page.tag_list=[] }

#Create page with same url as govbar dev config 'http://fabulous.url.gov'
FactoryGirl.create(:tagged_page)

#Create multiple pages with the same tag
(1..5).each { |num| FactoryGirl.create(:tagged_page, url: "www.testurl#{num}.gov") }