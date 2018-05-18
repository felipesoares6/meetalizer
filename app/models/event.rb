class Event < ApplicationRecord
  belongs_to :group
  has_many :event_organizers, inverse_of: :organized_event
  has_many :organizers, through: :event_organizers

  validates :name, :description, :address, :start_date, :end_date, presence: true
end
