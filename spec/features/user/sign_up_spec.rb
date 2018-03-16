require 'rails_helper'

feature 'Sign up' do
  given(:user) { build(:user) }

  scenario 'Sign up with valid fields' do
    visit new_user_registration_path

    within '[data-test="sign_up_form"]' do
      fill_in 'Name', with: user.name
      fill_in 'Bio',  with: user.bio
      fill_in 'Email', with: user.email
      fill_in 'Date of birth', with: user.date_of_birth
      fill_in 'Profile picture url', with: user.profile_picture_url
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: user.password

      click_button 'Sign up'
    end

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(page).to have_current_path(root_path)
  end

  scenario 'Sign up with the wrong password confirmation' do
    visit new_user_registration_path

    within '[data-test="sign_up_form"]' do
      fill_in 'Name', with: user.name
      fill_in 'Bio',  with: user.bio
      fill_in 'Email', with: user.email
      fill_in 'Date of birth', with: user.date_of_birth
      fill_in 'Profile picture url', with: user.profile_picture_url
      fill_in 'Password', with: user.password
      fill_in 'Password confirmation', with: 'wrongpasswordconfirmation'

      click_button 'Sign up'
    end

    expect(page).to have_content "Password confirmation doesn't match Password"
    expect(page).to have_current_path(user_registration_path)
  end
end
