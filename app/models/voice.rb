class Voice < ApplicationRecord
  belongs_to :training

  mount_uploader :voice_data, VoiceDataUploader
  validates :training_id, presence: true
  validates :voice_data, presence: true
  enum phase: { point: 0, reason: 1, example: 2, second_point: 3 }
end
