require 'rails_helper'

RSpec.describe MembershipsController do
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  describe 'POST create' do
    before { sign_in(user) }

    context 'with success' do
      it 'create a membership' do
        expect {
          post :create, params: { group_id: group.id }
        }.to change { Membership.count }.by(1)
      end

      it 'redirect to root' do
        post :create, params: { group_id: group.id }

        expect(response).to redirect_to(group_path(group.id))
      end
    end

    context 'with an error' do
      it 'do not create a membership' do
        expect {
          post :create, params: { group_id: '' }
        }.to change { Membership.count }.by(0)
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:membership) {
      create(
        :membership,
        user_id: user.id,
        group_id: group.id,
        role: :normal
      )
    }

    it 'do not destroy a membership' do
      sign_in(user)

      expect {
        delete :destroy, params: { group_id: group.id }
      }.to change { Membership.count }.by(-1)
    end
  end
end
