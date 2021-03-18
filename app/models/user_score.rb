class UserScore < ApplicationRecord
  belongs_to :user
  validates :max_score, numericality: { only_integer: true }
  validates :max_score, presence: true
end
