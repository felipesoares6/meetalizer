FactoryBot.define do
  factory :membership do
    user
    group
    role :admin
  end
end
