require 'faker'

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
  end
end

puts 'Users, groups and memberships created'
