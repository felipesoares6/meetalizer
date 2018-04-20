class GroupPolicy
  attr_reader :user, :group

  def initialize(user, group)
    @user = user
    @group = group
  end

  def edit?
    admin?
  end

  def update?
    admin?
  end

  def destroy?
    admin?
  end

  def become_member?
    !membership?
  end

  def leave?
    membership? && !admin?
  end

  private
  def admin?
    @admin ||= @group.memberships.admin.where(user: @user).any?
  end

  def membership?
    @membership ||= @group.memberships.where(user: @user).any?
  end
end
