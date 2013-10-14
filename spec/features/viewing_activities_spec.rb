require 'spec_helper'

feature "Viewing activities" do
  scenario "Listing all activities" do
    activity = FactoryGirl.create(:activity, name:"Student Project")
    visit '/'
    click_link 'Student Project'
    expect(page.current_url).to eql(activity_url(activity))
  end
end
