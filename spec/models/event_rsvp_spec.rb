require 'rails_helper'

RSpec.describe EventRsvp, type: :model do
  it { is_expected.to belong_to :rsvp }
  it { is_expected.to belong_to :answered_event }

  let(:group) { create(:group) }
  let(:user) { create(:user) }
  let(:event) { create(:event, group_id: group.id, rsvps_limit: 1) }

  describe '#can_answer_yes' do
    context 'when the answer is no' do
      let (:event_rsvp) { 
        create(
          :event_rsvp,
          user_id: user.id,
          event_id: event.id,
          answer: false
        )
      }

      it 'the event_rsvp is valid' do
        expect(event_rsvp.valid?).to equal(true)
      end
    end

    context 'when the answer is yes' do
      let (:event_rsvp) { 
        build(
          :event_rsvp,
          user_id: user.id,
          event_id: event.id,
          answer: true
        )
      }

      context 'and the event is full' do
        before do
          event.rsvps_limit = 0
          event.save
        end

        it 'the event_rsvp is invalid' do
          expect(event_rsvp.valid?).to be false
        end

        it 'set the error message' do
          event_rsvp.valid?

          expect(event_rsvp.errors.messages[:answer]).to match_array(['The event is full.'])
        end
      end

      context 'and the event is not full' do
        it 'the event_rsvp is valid' do
          expect(event_rsvp.valid?).to be true
        end
      end
    end
  end
end
