require 'spec_helper'

describe "actions/edit" do
  before(:each) do
    @actions = assign(:actions, stub_model(Actions))
  end

  it "renders the edit actions form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", actions_path(@actions), "post" do
    end
  end
end
