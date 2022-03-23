class Question < ApplicationRecord
  belongs_to :category
  has_many :trainings, dependent: :destroy
  
  mount_uploader :question_voice_data, QuestionVoiceDataUploader
  validates :category_id, presence: true
  validates :title, presence: true
end
