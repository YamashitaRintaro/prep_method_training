class Question < ApplicationRecord
  mount_uploader :question_voice_data, QuestionVoiceDataUploader
  validates :category_id, presence: true
  validates :title, presence: true
  belongs_to :category
end
