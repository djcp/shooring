require 'spec_helper'

feature "Seed Data" do
  scenario "The basics" do
    load Rails.root + "db/seeds.rb"
    user = User.where(email: "admin@example.com").first!
    user.password = "password"#
    activity = Activity.where(name: "Sample Project").first!

    sign_in_as!(user)
    click_link "Sample Project"
    click_link "New Folder"
    fill_in "Name", :with => "Comments with state"
    fill_in "Description", :with => "Comments always have a state."
    click_button "Create Folder"

    within("#comment_state_id") do
      page.should have_content("New")
      page.should have_content("Open")
      page.should have_content("Closed")
    end
  end
end
