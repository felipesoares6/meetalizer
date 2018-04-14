require 'rails_helper'

RSpec.describe User, type: :model do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :date_of_birth }
    it { is_expected.to validate_length_of(:bio).is_at_most(140) }
    it { is_expected.to have_many :memberships }
    it { is_expected.to have_many :groups }

    describe '#groups_as_admin' do
      context 'when the groups_as_admin is called' do
        let (:group) { create(:group) }
        let (:user) { create(:user) }
        let! (:membership) { create(:membership, user_id: user.id, group_id: group.id, role: :admin) }

        it 'bring the user administered groups' do
          groups = user.groups_as_admin

          expect(groups).to include(group)
        end
      end
    end
end
