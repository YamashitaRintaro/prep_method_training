class Training < ApplicationRecord
  belongs_to :user
  belongs_to :question
  
  validates :title, presence: true, length: { maximum: 255 }
end
