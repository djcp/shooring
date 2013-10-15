require 'spec_helper'

feature 'Creating Folders' do
  before do
    FactoryGirl.create(:activity, name:"Bash Project")
    visit '/'
    click_link "Bash Project"
    click_link "New Folder"
  end

  scenario "Creating a folder" do
    fill_in "Name", with:"Groupe 1"
    fill_in "Description", with: "Student Bob and Alice"
    click_button "Create Folder"

    expect(page).to have_content("Folder has been created.")
  end

  scenario "Creating a folder without valid attributes fails" do
    click_button "Create Folder"

    expect(page).to have_content("Folder has not been created.")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario "Description must be longer than 10 characters" do
    fill_in "Name", with:"Groupe 1"
    fill_in "Name", with:"Toto"
    click_button "Create Folder"

    expect(page).to have_content("Folder has not been created.")
    expect(page).to have_content("Description is too short")
  end
end
