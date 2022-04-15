FactoryBot.define do
  factory :category do
    name { '新卒' }
  end
  trait :category2 do
    name { '転職' }
  end
  trait :category3 do
    name { 'エンジニア' }
  end
end