require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Active Record' do
    context 'validations' do
      it { is_expected.to have_secure_password }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:phone_number) }
    end
  end
end
