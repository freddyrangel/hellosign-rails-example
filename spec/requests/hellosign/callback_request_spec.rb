require 'rails_helper'

RSpec.describe 'Callback Request', type: :request do
  describe 'post /signature_requests/callbacks' do
    before(:each) { post '/signature_requests/callbacks', {}, mime_json }
    it { expect(response.status).to eq(200) }
  end
end
