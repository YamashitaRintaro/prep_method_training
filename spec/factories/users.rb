FactoryBot.define do
  factory :user do
    association :category
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end

  trait :category2 do
    association :category2
  end

  trait :category3 do
    association :category3
  end

  trait :admin do
    role { 1 }
  end
end