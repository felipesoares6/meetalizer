class Group < ApplicationRecord
  has_many :memberships
  has_many :events
  has_many :users, through: :memberships

  validates :name, :description, :region, presence: true
  validates :description, length: { maximum: 130 }

  def admin?(user)
    memberships.admin.where(user: user).any?
  end

  def member?(user)
    memberships.normal.where(user: user).any?
  end
end
