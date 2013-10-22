require 'spec_helper'

feature 'Creating Folders' do
  before do
    activity = FactoryGirl.create(:activity)
    user = FactoryGirl.create(:user)
    define_permission!(user, "view", activity)
    define_permission!(user, "tag", activity)
    define_permission!(user, "create folders", activity)
    @email = user.email
    sign_in_as!(user)

    visit '/'
    click_link activity.name
    click_link 'New Folder'
  end

  scenario "Creating a folder" do
    fill_in "Name", with:"Groupe 1"
    fill_in "Description", with: "Student Bob and Alice"
    click_button "Create Folder"

    expect(page).to have_content("Folder has been created.")

    within "#folder #author" do
      expect(page).to have_content("Created by #{@email}")
    end
  end

  scenario "Creating a folder without valid attributes fails" do
    click_button "Create Folder"

    expect(page).to have_content("Folder has not been created.")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario "Description must be longer than 10 characters" do
    fill_in "Name", with:"Groupe 1"
    fill_in "Description", with:"Toto"
    click_button "Create Folder"

    expect(page).to have_content("Folder has not been created.")
    expect(page).to have_content("Description is too short")
  end

  scenario "Creating a folder with an attachment", js:true do
    fill_in "Name", with: "Activity for Alice"
    fill_in "Description", with: "Activity Readme file attached"

    attach_file "File #1", "spec/fixtures/Readme.md"

    click_link "Add another file"
    attach_file "File #2", "spec/fixtures/TODO.md"

    click_button "Create Folder"

    expect(page).to have_content("Folder has been created.")

    #within("#folder .asset") do
    #  expect(page).to have_content("Readme.md")
    #  expect(page).to have_content("TODO.md")
    #end
  end

  scenario "Creating a folder with tags" do
    fill_in "Name", with: "Project"
    fill_in "Description", with: "Bob and Alice"
    fill_in "Tags", with: "undone beta"
    click_button "Create Folder"

    page.should have_content("Folder has been created.")

    within("#folder #tags") do
      page.should have_content("undone")
      page.should have_content("beta")
    end
  end

end
