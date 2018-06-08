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

  def join?
    !member?
  end

  def leave?
    member? && !admin?
  end

  def create_an_event?
    admin?
  end

  private
  def admin?
    @admin ||= @group.admin?(@user)
  end

  def member?
    @member ||= @group.member?(@user)
  end
end
