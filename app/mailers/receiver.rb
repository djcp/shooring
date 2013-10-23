class Receiver < ActionMailer::Base
  default from: "from@example.com"

  def self.parse(email)
    reply_separator = /(.*?)\s?== ADD YOUR REPLY ABOVE THIS LINE ==/m
    comment_text = reply_separator.match(email.body.to_s)
    if comment_text
      to, activity_id, folder_id =
      email.to.first.split("@")[0].split("+")
      activity = Activity.find(activity_id)
      folder = activity.folders.find(folder_id)
      user = User.find_by_email(email.from[0])

      folder.comments.create({
        text: comment_text[1].strip,
        user: user
        })
    end
  end

end
