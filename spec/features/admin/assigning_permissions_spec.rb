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
  end

  scenario "Viewing a activity" do
    check_permission_box "view", activity
    click_button "Update"
    click_link "Sign out"
    sign_in_as!(user)
    expect(page).to have_content(activity.name)
  end

end
