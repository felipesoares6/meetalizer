require 'rails_helper'

RSpec.describe DashboardController do
  let (:group_as_admin) { create(:group) }
  let (:group_as_normal) { create(:group) }

  let (:user) { create(:user) }

  let! (:membership_as_admin) { create(:membership, user_id: user.id, group_id: group_as_admin.id, role: :admin) }
  let! (:membership_as_normal) { create(:membership, user_id: user.id, group_id: group_as_normal.id, role: :normal) }

  describe 'GET index' do
    before do
      sign_in(user)

      get :index
    end

    it 'assigns @groups_as_admin' do
      expect(assigns(:groups_as_admin)).to match_array([group_as_admin])
    end

    it 'assigns @groups_as_admin' do
      expect(assigns(:groups_as_normal)).to match_array([group_as_normal])
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
  end
end
