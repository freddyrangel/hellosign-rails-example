require 'rails_helper'

feature 'New Signature Request' do
  let!(:admin) { create(:user, :admin) }
  before(:each) { admin_login }

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
