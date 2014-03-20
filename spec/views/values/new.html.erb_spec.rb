require 'spec_helper'

describe "values/new" do
  before(:each) do
    assign(:value, stub_model(Value).as_new_record)
  end

  it "renders new value form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", values_path, "post" do
    end
  end
end
