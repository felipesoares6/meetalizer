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

  def full?
    rsvps_limit <= event_rsvps.where(answer: true).count
  end

  describe '#full?' do
    let(:group) { create(:group) }
    let(:attendee) { create(:user) }
    let(:user) { create(:user) }
    let(:membership) do
      create(:membership, user_id: user.id, group_id: group.id, role: :admin)
    end

    context 'and the event is full' do
      let(:event) { create(:event, group_id: group.id, rsvps_limit: 1) }
      let(:event_organizer) do
        create(:event_organizer, user_id: user.id, event_id: event.id)
      end
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

    context 'and the event is not full' do
      let(:event) { create(:event, group_id: group.id, rsvps_limit: 2) }
      let(:event_organizer) do
        create(:event_organizer, user_id: user.id, event_id: event.id)
      end
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
end
