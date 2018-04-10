require 'rails_helper'

feature 'User should be able to update a group' do
  context 'when the user has the admin role' do
    given (:group) { create(:group) }
    given (:user) { create(:user) }
    given! (:membership) { create(:membership, user_id: user.id, group_id: group.id, role: :admin) }

    scenario 'Update a group successfully' do
      login_as(user)

      visit root_path

      click_link group.name

      click_link 'Edit'

      within '[data-test="update_group_form"]' do
        fill_in 'Name', with: group.name
        fill_in 'Description', with: group.description
        fill_in 'Region', with: group.region
        fill_in 'Profile picture url', with: group.profile_picture_url
        fill_in 'Cover picture url', with: group.cover_picture_url

        click_button 'Save Group'
      end

      expect(page).to have_current_path(group_path(group.id))
    end
  end

  context 'when the user does not have the admin role' do
    given (:group) { create(:group) }
    given (:user) { create(:user) }
    given! (:membership) { create(:membership, user_id: user.id, group_id: group.id, role: :member) }

    scenario 'Do not update a group when the fields are invalid' do
      login_as(user)

      visit edit_group_path(group.id)

      expect(page).to have_content('You are not authorized to perform this action.')
    end
  end
end
