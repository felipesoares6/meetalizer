class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum role: [:admin, :normal]
end
