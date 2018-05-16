class Organizer < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, presence: true
end
