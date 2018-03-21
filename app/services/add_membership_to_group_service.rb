class AddMembershipToGroupService
  def initialize(user, group)
    @user = user
    @group = group
  end

  def self.perform(user, group)
    instance = new(user, group)

    ActiveRecord::Base.transaction do
      instance.create_membership
      instance.add_membership_to_group
    end
  end

  def create_membership
    @membership = Membership.new(user_id: @user.id, group_id: @group.id, role: :admin)
  end

  def add_membership_to_group
    @group.memberships << @membership
  end
end
