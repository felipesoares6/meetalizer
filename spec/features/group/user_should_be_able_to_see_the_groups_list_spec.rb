require 'rails_helper'

feature 'User should be able to see the groups list' do
  scenario 'List the groups when groups were created' do
    create(:group)

    visit root_path

    click_link 'Check all the groups'

    within '[data-test="groups_list"]' do
      expect(page).to have_content('group_name')
      expect(page).to have_content('Description: description')
      expect(page).to have_content('Region: region')
    end
  end

  scenario 'Show no groups message when no groups were created' do
    visit groups_path

    within '[data-test="groups_list"]' do
      expect(page).to have_content('No meetups were created yet, maybe you can create the first?')
    end
  end
end
