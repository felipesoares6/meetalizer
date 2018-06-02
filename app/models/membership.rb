class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :role, presence: true

  enum role: [:admin, :normal]
end
