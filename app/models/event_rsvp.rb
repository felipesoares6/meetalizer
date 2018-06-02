class EventRsvp < ApplicationRecord
  belongs_to :rsvp, class_name: 'User', foreign_key: 'user_id'
  belongs_to :answered_event, class_name: 'Event', foreign_key: 'event_id'

  delegate :name, to: :rsvp, prefix: :rsvp

  validate :answer_yes, on: :create
  validate :answer_yes, on: :update

  def answer_yes
    errors.add(:answer, 'The event is full.') if answer && full?
  end

  private

  def full?
    answered_yes = answered_event.event_rsvps.where(answer: true)
    answered_event.rsvps_limit <= answered_yes.count
  end
end
