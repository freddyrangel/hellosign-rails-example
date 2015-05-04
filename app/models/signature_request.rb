class SignatureRequest < ActiveRecord::Base
  validates :email, presence: true
  validates :name, presence: true
  validates :phone_number, presence: true

  before_create :generate_pin

  private

  def generate_pin
    self.pin = (0..3).map { |i| rand(0..9) }.join
  end
end
