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
  let(:attendee) { create(:user) }
  let(:user) { create(:user) }
  let(:user_rsvp_true) { create(:user) }
  let(:user_rsvp_false) { create(:user) }

  describe '#full?' do
    context 'when the event is full' do
      let(:event) { create(:event, group_id: group.id, rsvps_limit: 1) }
      let!(:event_rsvp) do
        create(
          :event_rsvp,
          user_id: attendee.id,
          event_id: event.id,
          answer: true
        )
      end

      it 'return true' do
        expect(event.full?).to equal(true)
      end
    end

    context 'when the event is not full' do
      let(:event) { create(:event, group_id: group.id, rsvps_limit: 2) }
      let!(:event_rsvp) do
        create(
          :event_rsvp,
          user_id: attendee.id,
          event_id: event.id,
          answer: true
        )
      end

      it 'return false' do
        expect(event.full?).to equal(false)
      end
    end
  end

  describe '#organizer?' do
    context 'when the user is an organizer' do
      let(:event) { create(:event, group_id: group.id, rsvps_limit: 1) }
      let!(:event_organizer) do
        create(:event_organizer, user_id: user.id, event_id: event.id)
      end

      it 'return true' do
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

  describe '#rsvp_answer?' do
    let(:event) { create(:event, group_id: group.id, rsvps_limit: 1) }

    context 'when user rsvp answer is true' do
      let!(:event_rsvp) do
        create(
          :event_rsvp,
          user_id: user_rsvp_true.id,
          event_id: event.id,
          answer: true
        )
      end

      it 'return true' do
        expect(event.rsvp_answer?(user_rsvp_true)).to equal(true)
      end
    end

    context 'when the user rsvp answer is false' do
      let!(:event_rsvp) do
        create(
          :event_rsvp,
          user_id: user_rsvp_false.id,
          event_id: event.id,
          answer: false
        )
      end

      it 'return false' do
        expect(event.rsvp_answer?(user_rsvp_false)).to equal(false)
      end
    end
  end
end
