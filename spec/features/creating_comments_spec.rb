require 'spec_helper'

feature "Creating comments" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:activity) { FactoryGirl.create(:activity) }
  let!(:folder) { FactoryGirl.create(:folder, :activity => activity, :user => user) }

  before do
    define_permission!(user, "view", activity)
    define_permission!(user, "tag", activity)

    FactoryGirl.create(:state, name: "Closed")

    sign_in_as!(user)
    visit '/'
    click_link activity.name
  end

  scenario "Creating a comment" do
    click_link folder.name
    fill_in "Text", with: "Added a comment!"
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

  scenario "Changing a folder's state", js: true do
    define_permission!(user, "change states", activity)
    click_link folder.name
    fill_in "Text", with: "Deadline ended"
    select "Closed", from: "State"
    click_button "Create Comment"
    page.should have_content("Comment has been created.")

    within("#folder .state") do
      page.should have_content("Closed")
    end

    within("#comments") do
      page.should have_content("State: Closed")
    end
  end

  scenario "A user without permission cannot change the state" do
    click_link folder.name
    message = 'Unable to find css "#comment_state_id"'
    expect {
      find("#comment_state_id")
    }.to raise_error(Capybara::ElementNotFound, message)
  end

  scenario "Adding a tag to a folder" do
    click_link folder.name
    within("#folder #tags") do
      page.should_not have_content("incomplete")
    end

    fill_in "Text", with: "Adding Incomplete"
    fill_in "Tags", with: "incomplete"
    click_button "Create Comment"

    page.should have_content("Comment has been created.")
    within("#folder #tags") do
      page.should have_content("incomplete")
    end
  end

end
