require 'spec_helper'

describe Habit do

  before :each do
    @habit = Habit.new
    @habit.valid?
  end

  it "should have some validation requirements" do
    @habit.should_not be_valid
  end

  it "should have a habit type" do
    @habit.errors.full_messages.should include "Habit type can't be blank"
  end

  it "should be the right type" do
    @habit.errors.full_messages.should include "Habit type is not included in the list"
  end



end
