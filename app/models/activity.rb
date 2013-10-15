class Activity < ActiveRecord::Base
  validates :name, presence: true

  has_many :folders, dependent: :delete_all #dependent: :nullify
end
