require 'spec_helper'

describe "Pages" do
  before do
    @page = Page.create!(:url => "http://www.example.gov")
  end
  
  describe "GET /pages?url=http://www.example.gov" do    
    context "when no url parameter is provided" do
      it "should return with an error" do
        get "/pages", :callback => "callback"
        response.status.should == 400
        response.body.should =~ /^callback\(.*\)$/
        parsed_json = JSON.parse(response.body.slice(/^callback\((.*)\)$/, 1))
        parsed_json["status"].should == "Error"
        parsed_json["message"].should == "url parameter required"
      end
    end
    
    context "when a url is provided" do
      it "should return information about the url" do
        get "/pages", :callback => "callback", :url => "http://www.example.gov"
        response.status.should == 200
        response.body.should =~ /^callback\(.*\)$/
        parsed_json = JSON.parse(response.body.slice(/^callback\((.*)\)$/, 1))
        parsed_json["url"].should == "http://www.example.gov/"
        parsed_json["path"].should == "/"
        parsed_json["related"].should be_empty
      end
    end
  end
  
  describe "GET /pages/:id" do
    context "when the id passed is not a valid page record" do
      it "should return an error" do
        get "/pages/12342343", :callback => "callback"
        response.status.should == 404
      end
    end
    
    context "when the id corresponds to a page" do
      it "should return information about the page" do
        get "/pages/#{@page.id}", :callback => "callback"
        response.status.should == 200
        response.body.should =~ /^callback\(.*\)$/
        parsed_json = JSON.parse(response.body.slice(/^callback\((.*)\)$/, 1))
        parsed_json["url"].should == "http://www.example.gov/"
        parsed_json["path"].should == "/"
        parsed_json["related"].should be_empty
      end
      
      context "when querying for the json format" do
        it "should respond successfully" do
          get "/pages/#{@page.id}.json", :callback => "callback"
          response.status.should == 200
        end
      end
    end
  end
end
