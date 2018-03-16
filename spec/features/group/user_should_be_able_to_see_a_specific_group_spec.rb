require 'rails_helper'

feature 'User should be able to see a specific group' do
  given (:group) { create(:group) }

  scenario 'Show the group' do

    visit group_path(group.id)

    within '[data-test="group_show"]' do
      expect(page).to have_content('Name: name')
      expect(page).to have_content('Description: description')
      expect(page).to have_content('Region: region')
    end
  end
end
