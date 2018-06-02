require 'faker'

email = 'felipe@felipe.com'
user = User.find_or_create_by!(email: email) do |user|
  user.name = Faker::Name.unique.name
  user.email = email
  user.password = 'felipe'
  user.date_of_birth = Faker::Date.unique.birthday(16, 80)
  user.profile_picture_url = 'https://url.com'
end

2.times do
  group = Group.find_or_create_by!(name: Faker::Name.unique.name) do |group|
    group.description = 'nice group'
    group.region = Faker::Address.city
    group.profile_picture_url = 'https://url.com'
    group.cover_picture_url = 'https://url.com'
  end

  Membership.create(user_id: user.id, group_id: group.id, role: :admin)

  2.times do |i|
    event = Event.find_or_create_by!(name: Faker::Name.unique.name) do |event|
      event.description = 'nice group'
      event.address = Faker::Address.city
      event.start_date = Time.now
      event.end_date = Time.now + 86400
      event.cover_picture_url = 'https://url.com'
      event.rsvps_limit = i * 5
      event.group = group
    end

    event.organizers << user
  end
end

10.times do |i|
   email = Faker::Internet.unique.email
   user = User.find_or_create_by!(email: email) do |user|
    user.name = Faker::Name.unique.name
    user.email = email
    user.password = 'qwerty'
    user.date_of_birth = Faker::Date.unique.birthday(16, 80)
    user.profile_picture_url = 'https://url.com'
  end

  2.times do |i|
    group = Group.find_or_create_by!(name: Faker::Name.unique.name) do |group|
      group.description = 'nice group'
      group.region = Faker::Address.city
      group.profile_picture_url = 'https://url.com'
      group.cover_picture_url = 'https://url.com'
    end

    Membership.create(user_id: user.id, group_id: group.id, role: :admin)

    2.times do |i|
      event = Event.find_or_create_by!(name: Faker::Name.unique.name) do |event|
        event.description = 'nice group'
        event.address = Faker::Address.city
        event.start_date = Time.now
        event.end_date = Time.now + 86400
        event.cover_picture_url = 'https://url.com'
        event.rsvps_limit = i * 5
        event.group = group
      end

      event.organizers << user
    end
  end
end

puts 'Users, groups and events created'
