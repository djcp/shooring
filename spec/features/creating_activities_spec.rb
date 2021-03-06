require 'spec_helper'

feature 'Creating Activity' do
  before do
    sign_in_as!(FactoryGirl.create(:admin_user))
    visit '/'
    click_link 'New Activity'
  end

  scenario "can create an activity" do
    fill_in 'Name', with: 'Student Project'
    fill_in 'Description', with: 'An activity for student project'
    click_button 'Create Activity'

    expect(page).to have_content('Activity has been created.')
    ####
    activity = Activity.where(name: 'Student Project').first

    expect(page.current_url).to eql(activity_url(activity))

    title = "Student Project - Activities - Shooring"
    expect(page).to have_title(title)
  end

  scenario "can not create an activity when with blank name" do
    click_button 'Create Activity'

    expect(page).to have_content("Activity has not been created")
    expect(page).to have_content("Name can't be blank")
  end

end
