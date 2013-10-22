class Notifier < ActionMailer::Base
  default from: "from@example.com"

  def comment_updated(comment, user)
    @comment = comment
    @user = user
    @folder = comment.folder
    @activity = @folder.activity

    subject = "[Shooring] #{@activity.name} - #{@folder.name}"

    mail(to: user.email, subject: subject)
  end
end
