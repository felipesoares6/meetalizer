FactoryBot.define do
  factory :event do
    name 'event_name'
    description 'description'
    address 'address'
    start_date Date.current
    end_date Date.current
    group
  end
end
