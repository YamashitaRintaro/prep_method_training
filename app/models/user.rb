class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :trainings, dependent: :destroy
  belongs_to :category

  validates :password, presence: true, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true, uniqueness: true
  enum role: { general: 0, admin: 1 }
end
