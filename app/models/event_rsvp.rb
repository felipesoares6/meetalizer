class EventRsvp < ApplicationRecord
  belongs_to :rsvp, class_name: 'User', foreign_key: 'user_id'
  belongs_to :answered_event, class_name: 'Event', foreign_key: 'event_id'

  delegate :name, to: :rsvp, prefix: :rsvp

  validate :can_answer_yes?, on: [:create, :update]

  def can_answer_yes?
    errors.add(:answer, 'The event is full.') if answer && answered_event.full?
  end
end
