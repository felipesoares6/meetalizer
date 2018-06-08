class Event < ApplicationRecord
  belongs_to :group
  has_many :event_organizers, inverse_of: :organized_event
  has_many :organizers, through: :event_organizers
  has_many :event_rsvps
  has_many :rsvps, through: :event_rsvps

  validates :name, :description, :address, :start_date, :end_date, presence: true

  def full?
    rsvps_limit <= (event_rsvps.where(answer: true).count || false)
  end

  def organizer?(user)
    organizers.where(id: user&.id).any?
  end

  def rsvp_answer?(user)
    event_rsvps.where(user_id: user&.id).first&.answer
  end
end
