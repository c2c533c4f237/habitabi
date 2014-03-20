require 'spec_helper'

describe "actions/new" do
  before(:each) do
    assign(:actions, stub_model(Actions).as_new_record)
  end

  it "renders new actions form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", actions_index_path, "post" do
    end
  end
end
