FactoryBot.define do
  factory :question do
    category_id { 1 }
    title { '自己紹介をしてください' }
    question_voice_data { fixture_file_upload("question1.wav", "audio/wav") }
    question_voice_data_seconds { 2 }
  end
end