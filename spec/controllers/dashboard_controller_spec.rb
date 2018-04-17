require 'rails_helper'

RSpec.describe DashboardController do
  let (:group) { create(:group) }
  let (:user) { create(:user) }
  let! (:membership) { create(:membership, user_id: user.id, group_id: group.id, role: :admin) }

  describe 'GET index' do
    before do
      sign_in(user)
      get :index
    end

    it 'assigns @groups' do
      expect(assigns(:groups)).to eq([group])
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
  end
end
