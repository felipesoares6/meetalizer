class EventOrganizer < ApplicationRecord
  belongs_to :organizer, class_name: 'User', foreign_key: 'user_id'
  belongs_to :organized_event, class_name: 'Event', foreign_key: 'event_id'
end
