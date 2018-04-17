require 'rails_helper'

RSpec.describe GroupsController do
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  let!(:membership) { create(:membership, user_id: user.id, group_id: group.id, role: :admin) }
  let(:group_params) { { name: group.name, description: group.description, region: group.region } }

  describe 'GET index' do
    before { get :index }

    it 'assigns @groups' do
      expect(assigns(:groups)).to eq([group])
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
  end

  describe 'GET show' do
    before { get :show, params: { id: group.id } }

    it 'assigns @group' do
      expect(assigns(:group)).to eq(group)
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end
  end

  describe 'GET new' do
    before do
      sign_in(user)

      get :new
    end

    it 'assigns @group' do
      expect(assigns(:group)).to be_a_new(Group)
    end

    it 'renders the new template' do
      expect(response).to render_template('new')
    end
  end

  describe 'POST create' do
    before { sign_in(user) }

    it 'create a group' do
      expect {
        post :create, params: {
          group: group_params
        }
      }.to change { Group.count }.by(1)
    end

    it 'call the AddMembershipToGroupService' do
      expect(AddMembershipToGroupService).to receive(:perform)

      post :create, params: { group: group_params }
    end

    it 'redirect to root' do
      post :create, params: { group: group_params }

      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET edit' do
    before do
      sign_in(user)

      get :edit, params: { id: group.id }
    end

    it 'assigns @group' do
      expect(assigns(:group)).to eq(group)
    end

    it 'renders the edit template' do
      expect(response).to render_template('edit')
    end
  end

  describe 'PUT update' do
    let(:fake_name) { 'test' }
    let(:group_params) { { name: fake_name, description: group.description, region: group.region } }

    before do
      sign_in(user)

      patch :update, params: { id: group.id, group: group_params }
    end

    it 'assigns @group' do
      expect(assigns(:group)).to eq(group)
    end

    it 'update the groups name' do
      expect(Group.last.name).to eq(fake_name)
    end

    it 'redirect to groups show' do
      expect(response).to redirect_to(group_path(group.id))
    end
  end

  describe 'DELETE destroy' do
    before { sign_in(user) }

    it 'assigns @group' do
      delete :destroy, params: { id: group.id }

      expect(assigns(:group)).to eq(group)
    end

    it 'delete a group' do
      expect {
        delete :destroy, params: { id: group.id }
      }.to change { Group.count }.by(-1)
    end
  end
end
