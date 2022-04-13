FactoryBot.define do
  factory :category do
    id { 1 }
    name { '新卒' }
  end
  factory :category2 do
    id { 2 }
    name { '転職' }
  end
  factory :category3 do
    id { 3 }
    name { 'エンジニア' }
  end
end