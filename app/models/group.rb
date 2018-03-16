class Group < ApplicationRecord
  has_and_belongs_to_many :users

  validates_presence_of :name, :description, :region
  validates_length_of :description, maximum: 130
end
