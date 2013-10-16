require 'spec_helper'

feature 'Viewing Folders' do
  before do
    student_project = FactoryGirl.create(:activity, name: "Student project")
    user = FactoryGirl.create(:user)
    ticket = FactoryGirl.create(:folder, activity: student_project, name:"Bash project", description:"Project for bob and Alice")
    ticket.update(user: user)

    meeting = FactoryGirl.create(:activity, name: "Meeting")
    FactoryGirl.create(:folder, activity: meeting, name:"Teachers Meeting", description:"Back to school teachers meeting")

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
