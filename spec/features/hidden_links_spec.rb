require 'spec_helper'

feature "hidden links" do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin_user) }
  let(:activity) { FactoryGirl.create(:activity) }
  let(:folder) { FactoryGirl.create(:folder, activity: activity,
                                    user: user) }

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

    scenario "New folder link is shown to a user with permission" do
      define_permission!(user, "view", activity)
      define_permission!(user, "create folders", activity)
      visit activity_path(activity)
      assert_link_for "New Folder"
    end

    scenario "New folder link is hidden from a user without permission" do
      define_permission!(user, "view", activity)
      visit activity_path(activity)
      assert_no_link_for "New Folder"
    end

    scenario "Edit folder link is shown to a user with permission" do
      folder
      define_permission!(user, "view", activity)
      define_permission!(user, "edit folders", activity)
      visit activity_path(activity)
      click_link folder.name
      assert_link_for "Edit Folder"
    end

    scenario "Edit folder link is hidden from a user without permission" do
      folder
      define_permission!(user, "view", activity)
      visit activity_path(activity)
      click_link folder.name
      assert_no_link_for "Edit Folder"
    end

    scenario "Delete folder link is shown to a user with permission" do
      folder
      define_permission!(user, "view", activity)
      define_permission!(user, "delete folders", activity)
      visit activity_path(activity)
      click_link folder.name
      assert_link_for "Delete Folder"
    end

    scenario "Delete folder link is hidden from users without permission" do
      folder
      define_permission!(user, "view", activity)
      visit activity_path(activity)
      click_link folder.name
      assert_no_link_for "Delete Folder"
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

    scenario "New folder link is shown to admins" do
      visit activity_path(activity)
      assert_link_for "New Folder"
    end

    scenario "Delete folder link is shown to admins" do
      folder
      visit activity_path(activity)
      click_link folder.name
      assert_link_for "Delete Folder"
    end
  end
end

