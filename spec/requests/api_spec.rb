require 'spec_helper'

describe "Apis" do

  before do
    @page = Page.create!(:url => "http://foo.gov/bar", :tag_list => "foo, bar")
  end
  
  describe "GET /" do
    context "when the user visits the root of the server" do
      it "should display the API documentation" do
        #todo: get visit to work here, and switch to have_content
        get '/' 
        response.code.should == "200"
        response.body.should match /.*retrieve a page by url.*/i
      end
      
      it "should prevent clickjacking" do
        get '/'
        response.headers['X-Frame-Options'].should == "SAMEORIGIN"
      end
    end
  end
  
  describe "GET /pages/1.json" do
    context "when a user requests a single page" do
      it "should return the page object" do
        get "/pages/#{@page.id}.json"
        response.code.should == "200"
        data = JSON.parse response.body
        data.should_not be_nil
        data["url"].should == @page.url
      end
      
      it "should return a callback if requested" do
        get "/pages/#{@page.id}.json?callback=my_awesome_callback"
        response.code.should == "200"
        response.body.should match /my_awesome_callback\(.*\)/
        data = JSON.parse /[^\(]*\((.*)\)/.match(response.body)[1]
        data.should_not be_nil
        data["id"].should == @page.id
      end
      
    end
  end
  
  describe "GET /pages/lookup.json" do
    context "when a user looksup a page by URL" do
      it "should return the page object" do
        get "/pages?url=#{@page.url}"
        response.code.should == "200"
        data = JSON.parse response.body
        data.should_not be_nil
        data["id"].should == @page.id
      end
    end
  end
  
  describe "GET /tags/foo.json" do
    context "when a user looksup a specific tag" do
      it "should return the resulting page object(s)" do
        get "/tags/foo.json"
        response.code.should == "200"
        data = JSON.parse response.body
        data.should_not be_nil
        data[0]["id"].should == @page.id
      end
    end
  end
  
  describe "PUT /pages/1.json" do
    context "when a user attempts to update a page" do
    
      it "should update the page's rating" do
        put "/pages/#{@page.id}.json?rating=5"
        response.code.should == "204"
        page = Page.find( @page.id )
        page.avg_rating.should == 5
      end
      
      it "should update the page's tags" do
        put "/pages/#{@page.id}.json", :page => { :tag_list => "a, b, c"}
        response.code.should == "204"
        page = Page.find( @page.id )
        page.tag_list.to_s.should == "a, b, c"
      end
      
      it "should return proper CORS headers" do
        put "/pages/#{@page.id}.json", :page => { :tag_list => "foo, bar"}
        response.headers["Access-Control-Allow-Methods"].should == "POST, GET, PUT, OPTIONS"
        response.headers["Access-Control-Allow-Origin"].should == "*"
      end
      
    end
  end
  
  describe "POST /pages/1/comments.json" do
    context "when a user attempt to createa a new comment" do
      it "should create a new comment" do
        post "/pages/#{@page.id}/comments.json", :body => "test"
        response.code.should == "201"
        data = JSON.parse response.body
        data["body"].should == "test"
      end
    end
  end

  describe "POST /pages/1/ratings.json" do
    context "when a user attempt to create a new rating" do
      it "should create a new rating for that page" do
        post "/pages/#{@page.id}/ratings.json", :value => 5
        response.code.should == "201"
        @page.reload
        @page.avg_rating.should == 5
      end
    end
  end
  
  describe "GET /pages/1/comments.json" do
    context "when the user requests a page's comments" do
      
      before do
        @user = User.new
        @user.ip = 'test'
        @user.save
      end
      
      before do
        @comment = Comment.new
        @comment.page_id = @page.id
        @comment.user_id = @user.id
        @comment.body = "test"
        @comment.save
      end
      
      it "should return the comments" do
        get "/pages/#{@page.id}/comments.json"
        response.code.should == "200"
        data = JSON.parse response.body
        data.should_not be_nil
        data[0]["body"].should == "test"
      end
      
    end
  end
  
end  