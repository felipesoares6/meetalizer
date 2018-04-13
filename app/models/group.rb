class Group < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships

  validates :name, :description, :region, presence: true
  validates :description, length: { maximum: 130 }
end
