class Job < ApplicationRecord
  has_many :shifts
  has_many :users, through: :shifts

  validates :title, presence: true
end
