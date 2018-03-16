class Group < ApplicationRecord
  has_many :memberships
  has_many :users, through: :memberships

  validates_presence_of :name, :description, :region
  validates_length_of :description, maximum: 130
end
