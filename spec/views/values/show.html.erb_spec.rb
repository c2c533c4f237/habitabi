require 'spec_helper'

describe "values/show" do
  before(:each) do
    @value = assign(:value, stub_model(Value))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
