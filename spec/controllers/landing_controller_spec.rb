require 'rails_helper'

RSpec.describe LandingController do
  let(:group) { create(:group) }

  describe 'GET index' do
    before { get :index }

    it 'assigns @groups' do
      expect(assigns(:groups)).to eq([group])
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end
  end
end
