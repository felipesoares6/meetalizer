require 'faker'

10.times do |i|
   email = Faker::Internet.unique.email
   user = User.find_or_create_by!(email: email) do |user| user.name = Faker::Name.unique.name
    user.email = email
    user.password = 'qwerty'
    user.date_of_birth = Faker::Date.unique.birthday(16, 80)
    user.profile_picture_url = 'https://url.com'
  end
end

puts 'Users created'
