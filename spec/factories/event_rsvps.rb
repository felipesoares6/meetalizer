FactoryBot.define do
  factory :event_rsvp do
    user
    event
    answer false
  end
end
