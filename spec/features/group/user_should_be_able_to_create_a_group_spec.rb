require 'rails_helper'

feature 'User should be able to create a group' do
  given (:group) { build(:group) }
  given (:user) { create(:user) }

  before do
    login_as(user)
  end

  scenario 'Create a group when the fields are valid' do
    visit root_path

    click_link 'Create group'

    within '[data-test="create_group_form"]' do
      fill_in 'Name', with: group.name
      fill_in 'Description', with: group.description
      fill_in 'Region', with: group.region
      fill_in 'Profile picture url', with: group.profile_picture_url
      fill_in 'Cover picture url', with: group.cover_picture_url

      click_button 'Save Group'
    end

    expect(page).to have_current_path(root_path)
  end

  scenario 'Do not create a group when the fields are invalid' do
    visit new_group_path

    within '[data-test="create_group_form"]' do
      fill_in 'Name', with: group.name
      fill_in 'Description', with: group.description
      click_button 'Save Group'
    end

    expect(page).to have_current_path(groups_path)
    expect(page).to have_content 'Region can\'t be blank'
  end
end
