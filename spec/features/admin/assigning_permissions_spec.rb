require 'spec_helper'

feature "Assigning permissions" do
  let!(:admin) { FactoryGirl.create(:admin_user) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:activity) { FactoryGirl.create(:activity) }
  let!(:folder) { FactoryGirl.create(:folder, activity: activity,
                                     user: user) }

  before do
    sign_in_as!(admin)

    click_link "Admin"
    click_link "Users"
    click_link user.email
    click_link "Permissions"

    State.create!(:name => "Open")
  end

  scenario "Viewing a activity" do
    check_permission_box "view", activity
    click_button "Update"
    click_link "Sign out"
    sign_in_as!(user)
    expect(page).to have_content(activity.name)
  end

  scenario "Creating folders for a activity" do
    check_permission_box "view", activity
    check_permission_box "create_folders", activity
    click_button "Update"
    click_link "Sign out"

    sign_in_as!(user)
    click_link activity.name
    click_link "New Folder"
    fill_in "Name", with: "Shiny!"
    fill_in "Description", with: "Make it so!"
    click_button "Create"

    expect(page).to have_content("Folder has been created.")
  end

  scenario "Updating a folder for a activity" do
    check_permission_box "view", activity
    check_permission_box "edit_folders", activity
    click_button "Update"
    click_link "Sign out"
    sign_in_as!(user)
    click_link activity.name
    click_link folder.name
    click_link "Edit Folder"
    fill_in "Name", with: "Really shiny!"
    click_button "Update Folder"
    expect(page).to have_content("Folder has been updated")
  end

  scenario "Deleting a folder for a activity" do
    check_permission_box "view", activity
    check_permission_box "delete_folders", activity
    click_button "Update"
    click_link "Sign out"
    sign_in_as!(user)
    click_link activity.name
    click_link folder.name
    click_link "Delete Folder"
    expect(page).to have_content("Folder has been deleted.")
  end

  scenario "Changing states for a folder", js: true do
    check_permission_box "view", activity
    check_permission_box "change_states", activity
    click_button "Update"
    click_link "Sign out"

    sign_in_as!(user)
    click_link activity.name
    click_link folder.name
    fill_in "Text", with: "Opening this folder."
    select "Open", from: "State"
    click_button "Create Comment"

    expect(page).to have_content("Comment has been created.")

    within("#folder .state") do
      expect(page).to have_content("Open")
    end
  end

end
