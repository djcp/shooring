class Comment < ActiveRecord::Base
  before_create :set_previous_state
  after_create :set_folder_state

  validates :text, presence: true
  belongs_to :folder
  belongs_to :user
  belongs_to :state

  belongs_to :previous_state, :class_name => "State"

  delegate :activity, :to => :folder

   private

    def set_folder_state
      self.folder.state = self.state
      self.folder.save!
    end

    def set_previous_state
      self.previous_state = folder.state
    end

end
