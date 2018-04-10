class User < ApplicationRecord
  has_many :memberships
  has_many :groups, through: :memberships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :date_of_birth, presence: true
  validates :bio, length: { maximum: 140 }

  def groups_as_admin
    groups.where(memberships: { role: :admin })
  end
end
