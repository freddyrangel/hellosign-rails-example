require 'rails_helper'

feature 'New Signature Request' do
  let!(:admin) { create(:user, :admin) }
  let(:mock_twilio) { instance_double("Twilio::REST::Client") }
  let(:mock_account) { double('account') }
  let(:mock_messages) { double('messages') }
  before(:each) do
    allow(mock_twilio).to receive(:account).and_return(mock_account)
    allow(mock_account).to receive(:messages).and_return(mock_messages)
    allow(mock_messages).to receive(:create).and_return(true)
    allow(HelloSign).to receive(:send_signature_request).and_return(true)
    allow(Twilio::REST::Client).to receive(:new).and_return(mock_twilio)
    admin_login
  end

  scenario 'admin send request' do
    fill_in 'Name',         with: 'Random Name'
    fill_in 'Email',        with: 'random@example.com'
    fill_in 'Phone number', with: '555-555-5555'
    click_on 'Send Signature Request'
  end

  private
  def admin_login
    visit root_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_on 'Login'
  end
end
