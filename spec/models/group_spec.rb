require 'rails_helper'

RSpec.describe Group, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :region }
  it { is_expected.to validate_length_of(:description).is_at_most(130) }
  it { is_expected.to have_many :memberships }
  it { is_expected.to have_many :users }
  it { is_expected.to have_many :events }

  let(:group) { create(:group) }
  let(:user) { create(:user) }

  describe '#admin?' do
    context 'when the user is an admin' do
      it 'return true' do
        create(
          :membership,
          user_id: user.id,
          group_id: group.id,
          role: :admin
        )

        expect(group.admin?(user)).to equal(true)
      end
    end

    context 'when the user is not an admin' do
      it 'return false' do
        create(
          :membership,
          user_id: user.id,
          group_id: group.id,
          role: :normal
        )

        expect(group.admin?(user)).to equal(false)
      end
    end
  end

  describe '#member?' do
    context 'when the user is a member' do
      it 'return true' do
        create(
          :membership,
          user_id: user.id,
          group_id: group.id,
          role: :normal
        )

        expect(group.member?(user)).to equal(true)
      end
    end

    context 'when the user is not a member' do
      it 'return false' do
        create(
          :membership,
          user_id: user.id,
          group_id: group.id,
          role: :admin
        )

        expect(group.member?(user)).to equal(false)
      end
    end
  end
end
