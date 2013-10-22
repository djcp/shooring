require 'spec_helper'

feature "Searching" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:activity) { FactoryGirl.create(:activity) }
  let!(:folder_1) do
    state = State.create(name: "Open")
    FactoryGirl.create(:folder,
            name: "Create activities",
            activity: activity,
            user: user,
            tag_names: "iteration_1",
            state: state)
  end

  let!(:folder_2) do
    state = State.create(name: "Closed")
    FactoryGirl.create(:folder,
            name: "Create users",
            activity: activity,
            user: user,
            tag_names: "iteration_2",
             state: state)
  end

  before do
    define_permission!(user, "view", activity)
    define_permission!(user, "tag", activity)

    sign_in_as!(user)
    visit '/'
    click_link activity.name
  end

  scenario "Finding by tag" do
    fill_in "Search", with: "tag:iteration_1"
    click_button "Search"
    within("#folders") do
      expect(page).to have_content("Create activities")
      expect(page).to_not have_content("Create users")
    end
  end

  scenario "Finding by state" do
    fill_in "Search", with: "state:Open"
    click_button "Search"
    within("#folders") do
      expect(page).to have_content("Create activities")
      expect(page).to_not have_content("Create users")
    end
  end

  scenario "Clicking a tag goes to search results" do
    click_link "Create activities"
    click_link "iteration_1"
    within("#folders") do
      expect(page).to have_content("Create activities")
      expect(page).to_not have_content("Create users")
    end
  end

end
