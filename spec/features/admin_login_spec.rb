require 'rails_helper'

feature 'Admin Login' do
  let!(:admin) { create(:user, :admin) }

  scenario 'admin login success' do
    visit root_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_on 'Login'
    expect(current_path).to eq(new_signature_request_path)
  end
end
