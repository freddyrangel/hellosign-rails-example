require 'rails_helper'

RSpec.describe SignatureRequestsController, type: :controller do
  describe '#new' do
    before(:each) { get :new }
    it { expect(response.status).to eq(200) }
  end
end
