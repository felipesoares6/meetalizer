require 'rails_helper'

RSpec.describe RsvpsController do
  let(:group) { create(:group) }
  let(:event) { create(:event, group_id: group.id) }
  let(:user) { create(:user) }
  let!(:membership) do
    create(:membership, user_id: user.id, group_id: group.id, role: :admin)
  end
  let(:event_rsvp) do
    create(:event_rsvp, user_id: user.id, event_id: event.id)
  end

  describe 'POST create' do
    before { sign_in(user) }

    context 'with success' do
      it 'create a rsvp' do
        expect {
          post :create, params: { group_id: group.id, event_id: event.id }
        }.to change { EventRsvp.count }.by(1)
      end

      it 'redirect to root' do
        post :create, params: { group_id: group.id, event_id: event.id }

        expect(response).to redirect_to(group_event_path(group, event))
      end

      it 'toggle the current rsvp answer' do
        rsvp_answer = event_rsvp.answer

        post :create, params: { group_id: group.id, event_id: event.id }

        expect(EventRsvp.last.answer).to equal(!rsvp_answer)
      end
    end

    context 'with an error' do
      it 'do not create a rsvp' do
        expect {
          post :create, params: { group_id: group.id, event_id: '' }
        }.to change { EventRsvp.count }.by(0)
      end

      it 'do not toggle the current rsvp answer' do
        rsvp_answer = event_rsvp.answer

        post :create, params: { group_id: group.id, event_id: '' }

        expect(EventRsvp.last.answer).to equal(rsvp_answer)
      end
    end
  end
end
