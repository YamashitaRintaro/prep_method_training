class Memo < ApplicationRecord
  belongs_to :training
  validates :body, presence: true, length: { maximum: 65_535 }
end
