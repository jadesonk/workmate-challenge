class User < ApplicationRecord
  has_many :shifts
  # I am assuming that a user can have multiple jobs for now
  has_many :jobs, through: :shifts

  validates :name, presence: true
end
