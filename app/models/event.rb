class Event < ApplicationRecord
  has_many :organizers
  has_many :users, through: :organizers
  belongs_to :group

  validates :name, :description, :address, :start_date, :end_date, presence: true
end
