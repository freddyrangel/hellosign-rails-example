require 'rails_helper'

RSpec.describe SignatureRequest, type: :model do
  describe 'Active Record' do
    context 'validations' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:phone_number) }
    end
  end
end
