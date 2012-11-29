require 'spec_helper'

describe "ratings/new" do
  before(:each) do
    assign(:rating, stub_model(Rating).as_new_record)
  end

  it "renders new rating form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ratings_path, :method => "post" do
    end
  end
end
