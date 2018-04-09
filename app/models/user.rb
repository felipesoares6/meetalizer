class User < ApplicationRecord
  has_many :memberships
  has_many :groups, through: :memberships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name, :date_of_birth
  validates_length_of :bio, maximum: 140

  def groups_as_admin
    groups.where(memberships: { role: :admin })
  end
end
