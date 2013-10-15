class Folder < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true,
            length: { minimum: 10 }
  belongs_to :activity
end
