require "spec_helper"

describe Receiver do
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

  it "parses a reply from a comment update into a comment" do
    original = Notifier.comment_updated(comment, folder_owner)
    reply_text = "This is a brand new comment"
    reply = Mail.new(from: commenter.email,
                     subject: "Re: #{original.subject}",
    body: %Q{#{reply_text}
      #{original.body}
    },
    to: original.reply_to)
    expect(lambda { Receiver.parse(reply) }).to(
     change(folder.comments, :count).by(1)
    )
    folder.comments.last.text.should eql(reply_text)
  end
end
