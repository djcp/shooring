class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true

  scope :for, ->(activity) do
    joins(:permissions).where(permissions: { action: "view",
                                             thing_type: "Activity",
                                             thing_id: activity.id })
  end

  has_many :permissions
  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end
end
