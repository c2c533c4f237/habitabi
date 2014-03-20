require 'spec_helper'

describe "actions/show" do
  before(:each) do
    @actions = assign(:actions, stub_model(Actions))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
