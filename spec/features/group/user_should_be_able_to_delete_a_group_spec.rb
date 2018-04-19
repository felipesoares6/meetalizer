require 'rails_helper'

feature 'User should be able to delete a group' do
  context 'when the user has the admin role' do
    given (:group) { create(:group) }
    given (:user) { create(:user) }
    given! (:membership) { create(:membership, user_id: user.id, group_id: group.id, role: :admin) }

    scenario 'Delete a group successfully' do
      login_as(user)

      visit root_path

      click_link 'group_name'

      click_button 'Delete'

      expect(page).to have_current_path(root_path)
      expect(page).not_to have_content('group_name')
    end
  end

  context 'when the user does not have the admin role' do
    given (:group) { create(:group) }
    given (:user) { create(:user) }
    given! (:membership) { create(:membership, user_id: user.id, group_id: group.id, role: :member) }

    scenario 'Do not delete a group' do
      login_as(user)

      visit root_path

      click_link 'Check the groups around'

      click_link 'group_name'

      expect(page).to have_current_path(group_path(group.id))
      expect(page).not_to have_content('Delete')
    end
  end
end
