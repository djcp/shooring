require 'spec_helper'

describe CommentsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:activity) { Activity.create!(name: "Ticketee") }

  let(:folder) do
    activity.folders.create(name: "State transitions",
                           description: "Can't be hacked.",
                           user: user)
  end
  let(:state) { State.create!(name: "New") }

  context "a user without permission to set state" do
    before do
      sign_in(user)
    end

    it "cannot transition a state by passing through state_id" do
      post :create, { comment: { text: "Hacked!",
                                 state_id: state.id },
                      folder_id: folder.id }
      folder.reload
      expect(folder.state).to be_nil
    end
  end
end
