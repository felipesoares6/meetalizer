class EventRsvp < ApplicationRecord
  belongs_to :rsvp, class_name: 'User', foreign_key: 'user_id'
  belongs_to :answered_event, class_name: 'Event', foreign_key: 'event_id'

  delegate :name, to: :rsvp, prefix: :rsvp
end
