FactoryBot.define do
  factory :question do
    title { '自己紹介をしてください' }
    question_voice_data { File.open(File.join(Rails.root, 'spec/fixtures/question1.wav')) }
    question_voice_data_seconds { 2 }
  end

  trait :question_category2 do
    title { '前職の業務内容を教えて下さい' }
    question_voice_data { File.open(File.join(Rails.root, 'spec/fixtures/question24.wav')) }
  end
end