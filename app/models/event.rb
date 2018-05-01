class Event < ApplicationRecord
  has_many :attendees
  has_many :users, through: :attendees
  belongs_to :group

  validates :name, :description, :address, :start_date, :end_date, presence: true
end
