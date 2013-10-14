require 'spec_helper'

feature 'Editing Activities' do
  before do
    FactoryGirl.create(:activity, name:'Student Project')
    visit '/'
    click_link 'Student Project'
    click_link "Edit Activity"
  end

  scenario 'Updating an activity' do
    fill_in "Name", with: "Student Project Beta"
    click_button "Update Activity"

    expect(page).to have_content("Activity has been updated.")
  end

  scenario 'Updating an activity with invalid attributes is bad' do
    fill_in "Name", with:""
    click_button "Update Activity"

    expect(page).to have_content("Activity has not been updated.")
  end
end
