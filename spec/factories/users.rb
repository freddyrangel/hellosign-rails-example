FactoryGirl.define do
  factory :user do
    sequence(:name)         { |u| "user_#{u}" }
    sequence(:email)        { |u| "user_#{u}@example.com" }
    phone_number            '555-555-5555'
    password                'password'
    password_confirmation   'password'

    trait :admin do
      admin true
    end
  end
end
