FactoryBot.define do
  factory :user do
    email 'email@email.com'
    password 'password'
    name 'name'
    bio 'bio'
    profile_picture_url 'https://pictureurl.com/picture-url'
    date_of_birth '1999-02-22'
  end
end
