FactoryGirl.define do
  factory :page do
    url 'http://fabulous.url.gov'
    title 'Fabulous gov title'
    initialize_with { Page.create(url: url)}

    factory :tagged_page do
      after :create do |page|
        page.tag_list.add('wondertag1')
        page.save
      end
    end
  end
end