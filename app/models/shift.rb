class Shift < ApplicationRecord
  belongs_to :user
  belongs_to :job

  validates :start_time, presence: true
end
