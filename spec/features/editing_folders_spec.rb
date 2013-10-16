require 'spec_helper'

feature 'Editing Folders' do
  let!(:activity) { FactoryGirl.create(:activity) }
  let!(:folder) { FactoryGirl.create(:folder, activity: activity ) }

  before do
    visit '/'
    click_link activity.name
    click_link folder.name
    click_link 'Edit Folder'
  end

  scenario 'Editing a folder' do
    fill_in "Name", with: "Student Important Project"
    click_button "Update Folder"

    expect(page).to have_content("Folder has been updated.")

    within("#folder h2") do
      expect(page).to have_content("Student Important Project")
    end

    expect(page).to_not have_content folder.name
  end

  scenario 'Editing a folder with invalid information fails' do
    fill_in "Name", with: ""
    click_button "Update Folder"

    expect(page).to have_content("Folder has not been updated.")
  end

end
