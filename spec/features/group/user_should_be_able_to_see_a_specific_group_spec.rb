require 'rails_helper'

feature 'User should be able to see a specific group' do
  given (:group) { create(:group) }
  given (:user) { create(:user) }
  given! (:membership) { create(:membership, user_id: user.id, group_id: group.id, role: :admin) }

  scenario 'Show the group' do
    visit root_path

    click_link group.name

    within '[data-test="group_show"]' do
      expect(page).to have_content('Name: name')
      expect(page).to have_content('Description: description')
      expect(page).to have_content('Region: region')
    end
  end
end
