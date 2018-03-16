class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum role: [:admin, :member]
end
