require 'rails_helper'

RSpec.describe AddMembershipToGroupService do
  let!(:group) { create(:group) }
  let!(:user) { create(:user) }

  it 'return a group with a membership' do
    expect {
      AddMembershipToGroupService.perform(user, group)
    }.to change {
      group.reload.memberships.length
    }.from(0).to(1)
  end
end
