require 'spec_helper'

feature "Creating comments" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:activity) { FactoryGirl.create(:activity) }
  let!(:folder) { FactoryGirl.create(:folder, :activity => activity, :user => user) }
  let!(:state) { FactoryGirl.create(:state, :name => "Closed") }

  before do
    define_permission!(user, "view", activity)
    sign_in_as!(user)
    visit '/'
    click_link activity.name
  end

  scenario "Creating a comment" do
    click_link folder.name
    fill_in "Text", :with => "Added a comment!"
    click_button "Create Comment"

    page.should have_content("Comment has been created.")

    within("#comments") do
      page.should have_content("Added a comment!")
    end
  end

  scenario "Creating an invalid comment" do
    click_link folder.name
    click_button "Create Comment"

    page.should have_content("Comment has not been created.")
    page.should have_content("Text can't be blank")
  end

  scenario "Changing a folder's state" do
    click_link folder.name
    fill_in "Text", :with => "Deadline ended"
    select "Closed", :from => "State"
    click_button "Create Comment"
    page.should have_content("Comment has been created.")

    within("#folder .state") do
      page.should have_content("Closed")
    end

    within("#comments") do
      page.should have_content("State: Closed")
    end

  end

end