FactoryBot.define do
  factory :question do
    category_id { 1 }
    title { '自己紹介をしてください' }
    question_voice_data { File.open(File.join(Rails.root, 'spec/fixtures/question1.wav')) }
    question_voice_data_seconds { 2 }
  end
end