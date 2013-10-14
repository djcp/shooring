require 'spec_helper'

feature 'Creating Activity' do
  scenario "can create an activity" do

    visit '/'

    click_link 'New Activity'

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
end
