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

    context "with permission to view the activity" do
      before do
        sign_in(user)
        define_permission!(user, "view", activity)
      end

      def cannot_create_folders!
        response.should redirect_to(activity)
        message = "You cannot create folders on this activity."
        flash[:alert].should eql(message)
      end

      it "cannot begin to create a folder" do
       get :new, :activity_id => activity.id
       cannot_create_folders!
      end

      it "cannot create a activity without permission" do
        post :create, :activity_id => activity.id
        cannot_create_folders!
      end
    end
  end
end
