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
    groups_as(:admin)
  end

  def groups_as_member
    groups_as(:member)
  end

  private
  def groups_as(role)
    groups.where(memberships: { role: role })
  end
end
