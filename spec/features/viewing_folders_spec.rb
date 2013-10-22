require 'spec_helper'

feature 'Viewing Folders' do
  before do
    user = FactoryGirl.create(:user)
    student_project = FactoryGirl.create(:activity, name: "Student project")
    define_permission!(user, "view", student_project)
    folder = FactoryGirl.create(:folder, activity: student_project, name:"Bash project", description:"Project for bob and Alice")
    folder.update(user: user)

    meeting = FactoryGirl.create(:activity, name: "Meeting")
    FactoryGirl.create(:folder, activity: meeting, name:"Teachers Meeting", description:"Back to school teachers meeting")
    define_permission!(user, "view", meeting)

    sign_in_as!(user)
    visit '/'
  end

  scenario 'Viewing folders for a given activity' do
    click_link 'Student project'

    expect(page).to have_content("Bash project")
    expect(page).to have_no_content("Teachers Meeting")

    click_link "Bash project"
    within("#folder h2") do
      expect(page).to have_content("Bash project")
    end
    expect(page).to have_content("Project for bob and Alice")
  end

end  
