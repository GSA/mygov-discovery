require 'spec_helper'

describe PagesController do
  describe "GET index" do
    before do
      Settings.stub(:maximum_related_results_display).and_return(15)
    end

    context "related count is set" do
      it "sets @related_count when related pages is less than the default max" do
        get :index, related: 2
        assigns(:related_count).should eq(2)
      end

      it "sets @related_count when related pages is greater than the default max" do
        get :index, related: 20
        assigns(:related_count).should eq(15)
      end
    end

    context "related count is not set" do
      it "sets @related_count from the settings" do
        get :index
        assigns(:related_count).should eq(15)
      end
    end
  end
end