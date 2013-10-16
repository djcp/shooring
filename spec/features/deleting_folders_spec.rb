require 'spec_helper'

feature 'Deleting Folders' do
  let!(:activity) { FactoryGirl.create(:activity) }
  let!(:folder) { FactoryGirl.create(:folder, activity: activity) }

  before do
    visit '/'
    click_link activity.name
    click_link folder.name
  end

  scenario 'Deleting a folder' do
    click_link 'Delete Folder'

    expect(page).to have_content('Folder has been deleted.')
    expect(page.current_url).to eql(activity_url(activity))
  end

end
