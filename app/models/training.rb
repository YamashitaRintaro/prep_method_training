class Training < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :voices
  
  validates :title, presence: true, length: { maximum: 255 }
end
