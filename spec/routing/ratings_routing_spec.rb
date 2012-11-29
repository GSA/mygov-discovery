require "spec_helper"

describe RatingsController do
  describe "routing" do

    it "routes to #index" do
      get("/ratings").should route_to("ratings#index")
    end

    it "routes to #new" do
      get("/ratings/new").should route_to("ratings#new")
    end

    it "routes to #show" do
      get("/ratings/1").should route_to("ratings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ratings/1/edit").should route_to("ratings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ratings").should route_to("ratings#create")
    end

    it "routes to #update" do
      put("/ratings/1").should route_to("ratings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ratings/1").should route_to("ratings#destroy", :id => "1")
    end

  end
end
