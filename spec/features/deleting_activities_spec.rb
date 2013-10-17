require 'spec_helper'

feature 'Deleting activities' do
  before do
    sign_in_as!(FactoryGirl.create(:admin_user))
  end

  scenario 'Deleting an activity' do

    FactoryGirl.create(:activity, name:'Student Project')

    visit '/'

    click_link 'Student Project'
    click_link 'Delete Activity'

    expect(page).to have_content('Activity has been deleted.')

    visit '/'

    expect(page).to have_no_content('Student Project')
  end
end
