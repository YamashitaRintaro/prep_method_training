FactoryBot.define do
  factory :voice do
    voice_data { File.open(File.join(Rails.root, 'spec/fixtures/question1.wav')) }

    trait :point do
      phase { 0 }
    end
  
    trait :reason do
      phase { 1 }
    end

    trait :example do
      phase { 2 }
    end

    trait :second_point do
      phase { 3 }
    end
  end
end