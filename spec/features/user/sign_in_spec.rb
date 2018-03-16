require 'rails_helper'

feature 'Sign in' do
  given(:user) { create(:user) }

  scenario 'Sign in with correct credentials' do
    visit login_path

    within '[data-test="sign_in_form"]' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_button 'Log in'
    end

    expect(page).to have_content 'Signed in successfully'
  end

  scenario 'Sign in with invalid credentials' do
    visit login_path

    within '[data-test="sign_in_form"]' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'wrongpassword'

      click_button 'Log in'
    end

    expect(page).to have_content 'Invalid Email or password'
  end
end
