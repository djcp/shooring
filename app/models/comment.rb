class Comment < ActiveRecord::Base
  belongs_to :folder
  belongs_to :user
  belongs_to :state
  belongs_to :previous_state, :class_name => "State"

  attr_accessor :tag_names

  validates :text, presence: true

  before_create :set_previous_state
  after_create  :set_folder_state
  after_create :associate_tags_with_folder
  after_create :creator_watches_folder

  delegate :activity, :to => :folder

  private

    def associate_tags_with_folder
      if tag_names
        tags = tag_names.split(" ").map do |name|
          Tag.find_or_create_by(name: name)
        end
        self.folder.tags += tags
        self.folder.save
      end
    end

    def set_previous_state
      self.previous_state = folder.state
    end

    def set_folder_state
      self.folder.state = self.state
      self.folder.save!
    end

    def creator_watches_folder
      folder.watchers << user
    end

end
