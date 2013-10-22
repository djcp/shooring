require 'spec_helper'

feature "Deleting tags" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:activity) { FactoryGirl.create(:activity) }
  let!(:folder) do
    FactoryGirl.create(:folder,
            activity: activity,
            tag_names: "this-tag-must-die",
            user: user)
  end

  before do
    sign_in_as!(user)
    define_permission!(user, "view", activity)
    define_permission!(user, "tag", activity)
    visit '/'
    click_link activity.name
    click_link folder.name
  end

  scenario "Deleting a tag", js: true do
    click_link "delete-this-tag-must-die"
    #within("#folder #tags") do
      expect(page).to_not have_content("this-tag-must-die")
    #end
  end
end
