require 'spec_helper'

describe Habit, type: :feature do

  context "Creating new" do

    it "should let the user know about missing full name" do

      visit '/habits/new'
      click_button "Create Habit"
      page.should have_content "Habit type can't be blank"

    end

    it "should let the user know about wrong habit type" do

      visit '/habits/new'
      fill_in 'Habit type', with: '29'
      click_button "Create Habit"
      page.should have_content "Habit type is not included in the list"

    end

    it "allow creation with a habit type" do
      visit '/habits/new'
      fill_in 'Habit type', with: '0'
      select "ate", from: "habit_action_id"
      select "taco", from: "habit_value_id"
      click_button "Habit"
      page.should have_content "Habit was successfully created."
      page.should have_content "0"
      page.should have_content "ate"
      page.should have_content "taco"
    end


  end

end

