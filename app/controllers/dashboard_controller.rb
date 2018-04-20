class DashboardController < ApplicationController
  def index
    @groups_as_admin = current_user.groups_as_admin
    @groups_as_normal = current_user.groups_as_normal
  end
end
