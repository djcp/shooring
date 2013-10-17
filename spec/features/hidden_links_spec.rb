require 'spec_helper'

feature "hidden links" do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin_user) }
  let(:activity) { FactoryGirl.create(:activity) }

  context "anonymous users" do
    scenario "cannot see the New Activity link" do
      visit '/'
      assert_no_link_for "New Activity"
    end

    scenario "cannot see the Edit Activity link" do
      visit activity_path(activity)
      assert_no_link_for "Edit Activity"
    end

    scenario "cannot see the Delete Activity link" do
      visit activity_path(activity)
      assert_no_link_for "Delete Activity"
    end
  end

  context "regular users" do
    before { sign_in_as!(user) }
      scenario "cannot see the New Activity link" do
      visit '/'
      assert_no_link_for "New Activity"
    end

    scenario "cannot see the Edit Activity link" do
      visit activity_path(activity)
      assert_no_link_for "Edit Activity"
    end

    scenario "cannot see the Delete Activity link" do
      visit activity_path(activity)
      assert_no_link_for "Delete Activity"
    end
  end

  context "admin users" do
    before { sign_in_as!(admin) }
     scenario "can see the New Activity link" do
       visit '/'
       assert_link_for "New Activity"
    end

    scenario "can see the Edit Activity link" do
      visit activity_path(activity)
      assert_link_for "Edit Activity"
    end

    scenario "can see the Delete Activity link" do
      visit activity_path(activity)
      assert_link_for "Delete Activity"
    end
  end
end

