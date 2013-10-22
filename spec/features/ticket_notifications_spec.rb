require "spec_helper"

feature "Folder Notifications" do
  let!(:alice) { FactoryGirl.create(:user, email: "alice@example.com") }
  let!(:bob) { FactoryGirl.create(:user, email: "bob@example.com") }
  let!(:activity) { FactoryGirl.create(:activity) }
  let!(:folder) do
    FactoryGirl.create(:folder,
                       activity: activity,
                       user: alice)
  end

  before do
    ActionMailer::Base.deliveries.clear

    define_permission!(alice, "view", activity)
    define_permission!(bob, "view", activity)

    sign_in_as!(bob)
    visit '/'
  end

  scenario "Folder owner receives notifications about comments" do
    click_link activity.name
    click_link folder.name
    fill_in "comment_text", with: "Is it out yet?"
    click_button  "Create Comment"

    email = find_email!(alice.email)
    subject = "[Shooring] #{activity.name} - #{folder.name}"
    expect(email.subject).to include(subject)
    click_first_link_in_email(email)

    within("#folder h2") do
      expect(page).to have_content(folder.name)
    end
  end
end

