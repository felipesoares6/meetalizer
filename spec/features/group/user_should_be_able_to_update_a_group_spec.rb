require 'rails_helper'

feature 'User should be able to update a group' do
  given (:group) { create(:group) }
  given (:user) { create(:user) }

  before do
    login_as(user)
  end

  scenario 'Update a group when the fields are valid' do
    visit edit_group_path(group.id)

    within '[data-test="update_group_form"]' do
      fill_in 'Name', with: group.name
      fill_in 'Description', with: group.description
      fill_in 'Region', with: group.region
      fill_in 'Profile picture url', with: group.profile_picture_url
      fill_in 'Cover picture url', with: group.cover_picture_url

      click_button 'Save Group'
    end

    expect(page).to have_current_path(groups_path)
  end

  scenario 'Do not update a group when the fields are invalid' do
    visit edit_group_path(group.id)

    within '[data-test="update_group_form"]' do
      fill_in 'Name', with: ''

      click_button 'Save Group'
    end

    expect(page).to have_current_path(groups_path)
    expect(page).to have_content 'Name can\'t be blank'
  end
end
