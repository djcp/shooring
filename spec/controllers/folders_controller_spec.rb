require 'spec_helper'

describe FoldersController do
  let(:user) { FactoryGirl.create(:user) }
  let(:activity) { FactoryGirl.create(:activity) }
  let(:folder) { FactoryGirl.create(:folder,
                                    activity: activity,
                                    user: user) }

  context "standard users" do
    it "cannot access a folder for an activity" do
      sign_in(user)
      get :show, :id => folder.id, :activity_id => activity.id
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eql("The activity you were looking " +
                                   "for could not be found.")
    end
  end

end
