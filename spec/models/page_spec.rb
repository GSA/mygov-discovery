require 'spec_helper'

describe Page do
  
  it "should parse the url into parts" do
    page = Page.new
    page.url = "http://my.usa.gov"
    page.parts.should be_an_instance_of Addressable::URI
  end
  
  it "should normalize missing http" do
    page = Page.create({:url => 'my.usa.gov'})
    page.url.should eq 'http://my.usa.gov/'
  end
  
  it "should strip anchor tags" do 
    page = Page.create({:url=>"my.usa.gov#about_us"})
    page.parts.path.should eq '/'
  end
  
  it "should associate a domain" do
    page = Page.create({:url=>"my.usa.gov"})
    page.domain.should be_an_instance_of Domain
  end
  
  it "should properly hash the url" do
    page = Page.create({:url=>"my.usa.gov"})
    page.url_hash.should eq Digest::MD5.hexdigest( 'http://my.usa.gov/' )
  end
  
end
