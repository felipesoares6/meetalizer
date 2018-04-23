require 'rails_helper'

feature 'User should be able to leave a group' do
  context 'when the user is a member of the group' do
    given! (:group) { create(:group) }
    given (:user) { create(:user) }
    given! (:membership) { create(:membership, user_id: user.id, group_id: group.id, role: :normal) }

    scenario 'Leave the group successfully' do
      login_as(user)

      visit root_path

      click_link 'Check the groups around'

      click_link 'group_name'

      click_button 'Leave group'

      expect(page).to have_current_path(group_path(group.id))
      expect(page).not_to have_button('Leave group')
      expect(page).to have_button('Join group')
    end
  end

  context 'when the user is an admin of the group' do
    given (:group) { create(:group) }
    given (:user) { create(:user) }
    given! (:membership) { create(:membership, user_id: user.id, group_id: group.id, role: :admin) }

    scenario 'Not be able to leave the group' do
      login_as(user)

      visit root_path

      click_link 'group_name'

      expect(page).to have_current_path(group_path(group.id))
      expect(page).not_to have_content('Leave')
    end
  end

  context 'when the user is not a normal member of the group' do
    given (:group) { create(:group) }
    given (:user) { create(:user) }
    given! (:membership) { create(:membership, user_id: user.id, group_id: group.id, role: :normal) }

    scenario 'Not be able to leave the group' do
      login_as(user)

      visit root_path

      click_link 'group_name'

      expect(page).to have_current_path(group_path(group.id))
      expect(page).not_to have_content('Leave')
    end
  end
end
