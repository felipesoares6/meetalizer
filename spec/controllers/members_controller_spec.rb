require 'rails_helper'

RSpec.describe MembersController do
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  let!(:membership) { create(:membership, user_id: user.id, group_id: group.id, role: :admin) }

  describe 'GET index' do
    before { get :index, params: { group_id: group.id }}

    it 'assigns @members' do
      expect(assigns(:members)).to eq([user])
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
  end
end
