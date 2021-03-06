class User < ApplicationRecord
  has_many :memberships
  has_many :event_organizers
  has_many :event_rsvps
  has_many :groups, through: :memberships
  has_many :organized_events, through: :event_organizers
  has_many :answered_events, through: :event_rsvps

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :date_of_birth, presence: true
  validates :bio, length: { maximum: 140 }

  def groups_as_admin
    groups_as(:admin)
  end

  def groups_as_normal
    groups_as(:normal)
  end

  private

  def groups_as(role)
    groups.where(memberships: { role: role })
  end
end
