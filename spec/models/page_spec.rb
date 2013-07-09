require 'spec_helper'

describe Page do

  describe "Page#hash_url" do
    it "should return nil if no url is provided" do
      Page.hash_url(nil).should_not be_nil
    end

    it "should return a hash of a url if one is provided" do
      hash = Page.hash_url("http://www.example.gov")
      hash.should_not be_nil
      hash.length.should == 32
    end

    it "should normalize urls before hashing them" do
      Page.hash_url("http://www.example.gov").should == Page.hash_url("http://www.example.gov/")
    end
  end

  it "should normalize missing http" do
    page = Page.create!(:url => 'my.usa.gov')
    page.url.should eq 'http://my.usa.gov/'
  end

  it "should strip anchor tags" do
    page = Page.create!(:url => "my.usa.gov#about_us")
    page.path.should eq '/'
  end

  it "should associate a domain" do
    page = Page.create(:url => "my.usa.gov")
    page.domain.should be_an_instance_of Domain
  end

  it "should properly hash the url" do
    page = Page.create(:url=>"my.usa.gov")
    page.url_hash.should eq Digest::MD5.hexdigest('http://my.usa.gov/')
  end
end
