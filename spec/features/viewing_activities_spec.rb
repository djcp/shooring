require 'spec_helper'

feature "Viewing activities" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:activity) { FactoryGirl.create(:activity) }

  before do
    sign_in_as!(user)
    define_permission!(user, :view, activity)
  end

  scenario "Listing all activities" do
    visit '/'
    click_link activity.name
    expect(page.current_url).to eql(activity_url(activity))
  end
end
