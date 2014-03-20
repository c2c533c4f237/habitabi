require 'spec_helper'

describe "actions/index" do
  before(:each) do
    assign(:actions, [
      stub_model(Actions),
      stub_model(Actions)
    ])
  end

  it "renders a list of actions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
