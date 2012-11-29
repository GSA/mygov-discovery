require 'spec_helper'

describe "ratings/show" do
  before(:each) do
    @rating = assign(:rating, stub_model(Rating))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
