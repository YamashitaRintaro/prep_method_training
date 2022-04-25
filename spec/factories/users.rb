FactoryBot.define do
  factory :user do
    association :category
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end

  trait :admin do
    role { 1 }
  end
end
