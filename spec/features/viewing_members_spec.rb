require 'spec_helper'

feature "Viewing members" do
  let!(:admin) { FactoryGirl.create(:admin_user) }
  let!(:member) { FactoryGirl.create(:user) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:activity) { FactoryGirl.create(:activity) }

  before do
    define_permission!(member, "view", activity)
    sign_in_as!(admin)

    click_link activity.name
    click_link "Members"
  end

  scenario "Viewing members of an activity" do
    expect(page).to have_content(member.name)
    expect(page).to_not have_content(user.name)
  end

end
