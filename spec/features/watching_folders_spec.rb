require 'spec_helper'

feature "Watching folders" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:activity) { FactoryGirl.create(:activity) }
  let!(:folder) { FactoryGirl.create(:folder, activity: activity,
                                   user: user) }

  before do
    define_permission!(user, "view", activity)
    sign_in_as!(user)
    visit '/'
  end

  scenario "Ticket watch toggling" do
    click_link activity.name
    click_link folder.name
    within("#watchers") do
      expect(page).to have_content(user.email)
    end

    click_button "Stop watching this folder"
    expect(page).to have_content("You are no longer watching this folder.")
    within("#watchers") do
      expect(page).to_not have_content(user.email)
    end
  end
end
