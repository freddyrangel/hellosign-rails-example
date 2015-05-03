require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user) { create(:user) }

  describe '#new' do
    before(:each) { get :new }
    it { expect(response.status).to eq(200) }
  end

  describe '#create' do
    context 'happy path' do
      let(:create_params) do
        { email: user.email, password: user.password }
      end
      before(:each) { post :create, create_params }

      it { expect(response).to redirect_to(new_signature_request_path) }
    end

    context 'sad path' do
      let(:create_params) do
        { email: user.email, password: 'wrong password' }
      end
      before(:each) { post :create, create_params }

      it { expect(response).to render_template(:new) }
    end
  end
end
