class SignatureRequest < ActiveRecord::Base
  validates :email, presence: true
  validates :name, presence: true
  validates :phone_number, presence: true
end
