require 'rails_helper'

RSpec.describe EventsController do
  let(:group) { create(:group) }
  let(:event) { create(:event, group_id: group.id) }
  let(:user) { create(:user) }
  let!(:membership) do
    create(:membership, user_id: user.id, group_id: group.id, role: :admin)
  end
  let!(:event_organizer) do
    create(:event_organizer, user_id: user.id, event_id: event.id)
  end
  let(:event_params) do
    {
      name: event.name,
      description: event.description,
      address: event.address,
      start_date: event.start_date,
      end_date: event.end_date
    }
  end

  describe 'GET index' do
    before { get :index, params: { group_id: group.id }}

    it 'assigns @events' do
      expect(assigns(:events)).to eq(group.events)
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
  end

  describe 'GET show' do
    before { get :show, params: { group_id: group.id, id: event.id } }

    it 'assigns @group' do
      expect(assigns(:group)).to eq(group)
    end

    it 'assigns @event' do
      expect(assigns(:event)).to eq(event)
    end

    it 'assigns @can_update' do
      expect(assigns(:can_update)).to eq(false)
    end

    it 'assigns @can_destroy' do
      expect(assigns(:can_destroy)).to eq(false)
    end

    it 'assigns @can_rsvp' do
      expect(assigns(:can_rsvp)).to eq(true)
    end

    it 'assigns @can_rsvp_with_yes' do
      expect(assigns(:can_rsvp_with_yes)).to eq(true)
    end

    it 'assigns @can_rsvp_with_no' do
      expect(assigns(:can_rsvp_with_no)).to eq(true)
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end
  end

  describe 'GET new' do
    before do
      sign_in(user)

      get :new, params: { group_id: group.id }
    end

    it 'assigns @event' do
      expect(assigns(:event)).to be_a_new(Event)
    end

    it 'renders the new template' do
      expect(response).to render_template('new')
    end
  end

  describe 'POST create' do
    before { sign_in(user) }

    context 'with success' do
      it 'create an event' do
        expect {
          post :create, params: {
            group_id: group.id,
            event: event_params
          }
        }.to change { Event.count }.by(1)
      end

      it 'redirect to events show' do
        post :create, params: {
          group_id: group.id,
          event: event_params
        }

        expect(response).to redirect_to(group_event_path(group, Event.last))
      end
    end

    context 'with an error' do
      it 'do not create an event' do
        expect {
          post :create, params: {
            group_id: group.id,
            event: { name: 'event_name', description: 'description' }
          }
        }.to change { Group.count }.by(0)
      end
    end
  end

  describe 'GET edit' do
    before do
      sign_in(user)

      get :edit, params: {
        group_id: group.id,
        id: event.id
      }
    end

    it 'assigns @group' do
      expect(assigns(:group)).to eq(group)
    end

    it 'assigns @event' do
      expect(assigns(:event)).to eq(event)
    end

    it 'renders the edit template' do
      expect(response).to render_template('edit')
    end
  end

  describe 'PUT update' do
    let(:fake_name) { 'test' }
    let(:event_params) do
      {
        name: fake_name,
        description: event.description,
        address: event.address,
        start_date: event.start_date,
        end_date: event.end_date
      }
    end

    before { sign_in(user) }

    it 'assigns @group' do
      patch :update, params: {
        group_id: group.id,
        id: event.id,
        event: event_params
      }

      expect(assigns(:group)).to eq(group)
    end

    it 'assigns @event' do
      patch :update, params: {
        group_id: group.id,
        id: event.id,
        event: event_params
      }

      expect(assigns(:event)).to eq(event)
    end

    context 'with success' do
      before do
        patch :update, params: {
          group_id: group.id,
          id: event.id,
          event: event_params
        }
      end

      it 'update the events name' do
        expect(Event.last.name).to eq(fake_name)
      end

      it 'redirect to events show' do
        expect(response).to redirect_to(group_event_path(group, event))
      end
    end

    context 'with an error' do
      before do
        patch :update, params: {
          group_id: group.id,
          id: event.id,
          event: { name: '' }
        }
      end

      it 'do not update the events name' do
        expect(Event.last.name).to eq(event.name)
      end
    end
  end

  describe 'DELETE destroy' do
    before { sign_in(user) }

    it 'assigns @event' do
      delete :destroy, params: {
        group_id: group.id,
        id: event.id
      }

      expect(assigns(:event)).to eq(event)
    end

    it 'delete an event' do
      expect {
        delete :destroy, params: {
          group_id: group.id,
          id: event.id
        }
      }.to change { Event.count }.by(-1)
    end
  end
end
