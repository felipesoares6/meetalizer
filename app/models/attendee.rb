class Attendee < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, :role, presence: true

  enum role: [:organizer, :normal]
end
