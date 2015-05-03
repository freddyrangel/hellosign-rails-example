require 'rails_helper'

RSpec.describe SignatureRequestsController, type: :controller do

  describe '#index' do
    let!(:signature_request) { create(:signature_request) }
    before(:each) { get :index }

    it { expect(response.status).to eq(200) }
    it { expect(assigns(:signature_requests).to_a).to eq([signature_request]) }
  end

  describe '#new' do
    before(:each) { get :new }
    it { expect(response.status).to eq(200) }
  end

  describe '#create' do
    context 'happy path' do
      let(:create_params) do
        {
          signature_request: {
            email: 'random@example.com',
            name: 'Random name',
            phone_number: '555-555-5555',
          }
        }
      end

      before(:each) { post :create, create_params }
      it { expect(response).to redirect_to(signature_requests_path) }
      it { expect(SignatureRequest.count).to eq(1) }
    end

    context 'sad path' do
      let(:create_params) do
        {
          signature_request: {
            name: 'Random name',
            phone_number: '555-555-5555',
          }
        }
      end

      before(:each) { post :create, create_params }
      it { expect(response).to render_template(:new) }
      it { expect(SignatureRequest.count).to eq(0) }

    end
  end
end
