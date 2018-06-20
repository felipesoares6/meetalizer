require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :address }
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :end_date }
  it { is_expected.to have_many :event_organizers }
  it { is_expected.to have_many :organizers }
  it { is_expected.to have_many :event_rsvps }
  it { is_expected.to have_many :rsvps }

  let(:group) { create(:group) }
  let(:user) { create(:user) }

  describe '#full?' do
    let(:event) { create(:event, group_id: group.id, rsvps_limit: 1) }

    context 'when the event is full' do
      before do
        create(
          :event_rsvp,
          user_id: user.id,
          event_id: event.id,
          answer: true
        )
      end

      it 'return true' do
        expect(event.full?).to equal(true)
      end
    end

    context 'when the event is not full' do
      it 'return false' do
        expect(event.full?).to equal(false)
      end
    end
  end

  describe '#organizer?' do
    context 'when the user is an organizer' do
      let(:event) { create(:event, group_id: group.id, rsvps_limit: 1) }

      it 'return true' do
        create(:event_organizer, user_id: user.id, event_id: event.id)

        expect(event.organizer?(user)).to equal(true)
      end
    end

    context 'when the user is not an organizer' do
      let(:event) { create(:event, group_id: group.id, rsvps_limit: 1) }

      it 'return false' do
        expect(event.organizer?(user)).to equal(false)
      end
    end
  end

  describe '#rsvp_answer' do
    let(:event) { create(:event, group_id: group.id, rsvps_limit: 1) }

    context 'when user rsvp answer is true' do
      it 'return true' do
        create(
          :event_rsvp,
          user_id: user.id,
          event_id: event.id,
          answer: true
        )

        expect(event.rsvp_answer(user)).to equal(true)
      end
    end

    context 'when the user rsvp answer is false' do
      it 'return false' do
        create(
          :event_rsvp,
          user_id: user.id,
          event_id: event.id,
          answer: false
        )

        expect(event.rsvp_answer(user)).to equal(false)
      end
    end
  end
end
