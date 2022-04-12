class Category < ApplicationRecord
  validates :name, presence: true
  has_many :users, dependent: :destroy
  has_many :questions, dependent: :destroy
end
