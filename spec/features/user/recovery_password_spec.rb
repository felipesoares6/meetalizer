require 'rails_helper'

feature 'Recovery Password' do
  given (:user) { create(:user) }

  scenario 'Recovery the password with the correct recovery url' do
    visit login_path

    click_link 'Forgot your password?'

    expect(page).to have_current_path(new_user_password_path)

    within '[data-test="recovery_password_form"]' do
      fill_in 'Email', with: user.email

      click_button 'Send me reset password instructions'
    end

    expect(page).to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'
    expect(page).to have_current_path(new_user_session_path)

    message = ActionMailer::Base.deliveries[0].to_s
    rpt_index = message.index("reset_password_token")+"reset_password_token".length+1
    reset_password_token = message[rpt_index...message.index("\"", rpt_index)]

    visit edit_user_password_url(user, reset_password_token: reset_password_token)

    within '[data-test="reset_password_form"]' do
      fill_in 'New password', with: 'new_password'
      fill_in 'Confirm new password', with: 'new_password'

      click_button 'Change my password'
    end

    expect(page).to have_content 'Your password has been changed successfully. You are now signed in.'
    expect(page).to have_current_path(root_path)
  end

  scenario 'Do not recovery the password with an invalid token' do
    visit login_path

    click_link 'Forgot your password?'

    expect(page).to have_current_path(new_user_password_path)

    within '[data-test="recovery_password_form"]' do
      fill_in 'Email', with: user.email

      click_button 'Send me reset password instructions'
    end

    expect(page).to have_content 'You will receive an email with instructions on how to reset your password in a few minutes.'
    expect(page).to have_current_path(new_user_session_path)

    visit edit_user_password_url(user, reset_password_token: 'wrong-token-123')

    within '[data-test="reset_password_form"]' do
      fill_in 'New password', with: 'new_password'
      fill_in 'Confirm new password', with: 'new_password'

      click_button 'Change my password'
    end

    expect(page).to have_content 'Reset password token is invalid'
    expect(page).to have_current_path(user_password_path)
  end
end
