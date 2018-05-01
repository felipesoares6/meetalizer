require 'rails_helper'

feature 'User should be able to join a group' do
  context 'when the user is not a member of the group' do
    given! (:group) { create(:group) }
    given (:user) { create(:user) }

    scenario 'Join the group successfully' do
      login_as(user)

      visit root_path

      click_link 'Check the groups around'

      click_link 'group_name'

      click_button 'Join group'

      expect(page).to have_current_path(group_path(group.id))
      expect(page).not_to have_button('Join group')
      expect(page).to have_button('Leave group')
    end
  end

  context 'when the user is an admin of the group' do
    given (:group) { create(:group) }
    given (:user) { create(:user) }
    given! (:membership) { create(:membership, user_id: user.id, group_id: group.id, role: :admin) }

    scenario 'Not be able to join the group' do
      login_as(user)

      visit root_path

      click_link 'group_name'

      expect(page).to have_current_path(group_path(group.id))
      expect(page).not_to have_content('Join')
    end
  end

  context 'when the user is already a normal member of the group' do
    given (:group) { create(:group) }
    given (:user) { create(:user) }
    given! (:membership) { create(:membership, user_id: user.id, group_id: group.id, role: :normal) }

    scenario 'Not be able to become a member of the group' do
      login_as(user)

      visit root_path

      click_link 'group_name'

      expect(page).to have_current_path(group_path(group.id))
      expect(page).not_to have_content('Join')
    end
  end
end
