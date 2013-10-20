class Comment < ActiveRecord::Base
  after_create :set_folder_state

  validates :text, presence: true
  belongs_to :folder
  belongs_to :user
  belongs_to :state

  delegate :activity, :to => :ticket

   private

    def set_folder_state
      self.folder.state = self.state
      self.folder.save!
    end
end
