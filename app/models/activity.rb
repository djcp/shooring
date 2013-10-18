class Activity < ActiveRecord::Base
  validates :name, presence: true

  has_many :folders, dependent: :delete_all #dependent: :nullify
  has_many :permissions, as: :thing

  scope :viewable_by, ->(user) do
    joins(:permissions).where(permissions: { action: "view",
                                             user_id: user.id })
  end

  scope :for, ->(user) do
    user.admin? ? Activity.all : Activity.viewable_by(user)
  end
end
