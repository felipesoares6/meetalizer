class DashboardController < ApplicationController
  def index
    @user = current_user
    @groups = Group.includes(:memberships).where(memberships: { user_id: @user.id, role: :admin })
  end
end
