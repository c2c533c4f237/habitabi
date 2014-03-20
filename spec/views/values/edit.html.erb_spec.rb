require 'spec_helper'

describe "values/edit" do
  before(:each) do
    @value = assign(:value, stub_model(Value))
  end

  it "renders the edit value form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", value_path(@value), "post" do
    end
  end
end
