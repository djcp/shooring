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

      def cannot_update_folders!
        expect(response).to redirect_to(activity)
        expect(flash[:alert]).to eql("You cannot edit folders on this activity.")
      end

      it "cannot begin to create a folder" do
       get :new, :activity_id => activity.id
       cannot_create_folders!
      end

      it "cannot create a activity without permission" do
        post :create, :activity_id => activity.id
        cannot_create_folders!
      end

      it "cannot edit a folder without permission" do
       get :edit, { activity_id: activity.id, id: folder.id }
       cannot_update_folders!
      end

      it "cannot update a folder without permission" do
        put :update, { activity_id: activity.id,
                       id: folder.id,
                       folder: {}
                     }
        cannot_update_folders!
      end

      it "cannot delete a folder without permission" do
        delete :destroy, { activity_id: activity.id, id: folder.id }
        expect(response).to redirect_to(activity)
        message = "You cannot delete folders from this activity."
        expect(flash[:alert]).to eql(message)
      end

      it "can create folders, but not tag them" do
         Permission.create(user: user,
                           thing: activity,
                           action: "create folders")
         post :create, folder: { title: "New folder!",
                                 description: "Brand spankin' new",
                                 tag_names: "these are tags"
                               },
                    activity_id: activity.id
         #expect(Folder.last.tags).to be_empty
       end
    end
  end
end
