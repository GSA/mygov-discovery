require 'spec_helper'

describe "ratings/index" do
  before(:each) do
    assign(:ratings, [
      stub_model(Rating),
      stub_model(Rating)
    ])
  end

  it "renders a list of ratings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
