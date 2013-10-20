class Folder < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true,
            length: { minimum: 10 }

  belongs_to :activity
  belongs_to :state
  belongs_to :user

  has_many :assets
  accepts_nested_attributes_for :assets

  has_many :comments
end
