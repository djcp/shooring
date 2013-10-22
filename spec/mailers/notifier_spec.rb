require "spec_helper"

describe Notifier do
  context "comment_updated" do
    let!(:activity) { FactoryGirl.create(:activity) }
    let!(:folder_owner) { FactoryGirl.create(:user) }
    let!(:folder) { FactoryGirl.create(:folder, activity: activity,
                                     user: folder_owner) }
    let!(:commenter) { FactoryGirl.create(:user) }
    let(:comment) do
      Comment.new({
        folder: folder,
        user: commenter,
        text: "Test comment"
        })
    end

    let(:email) do
       Notifier.comment_updated(comment, folder_owner)
    end

    it "sends out an email notification about a new comment" do
      expect(email.to).to include(folder_owner.email)
      title = "#{folder.name} for #{activity.name} has been updated."
      expect(email.body.to_s).to include(title)
      expect(email.body.to_s).to include("#{comment.user.email} wrote:")
      expect(email.body.to_s).to include(comment.text)
    end
  end
end
