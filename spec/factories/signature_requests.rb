FactoryGirl.define do
  factory :signature_request do
    sequence(:name)         { |u| "user_#{u}" }
    sequence(:email)        { |u| "user_#{u}@example.com" }
    phone_number            '555-555-5555'
  end
end
