require 'spec_helper'

describe "values/index" do
  before(:each) do
    assign(:values, [
      stub_model(Value),
      stub_model(Value)
    ])
  end

  it "renders a list of values" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
