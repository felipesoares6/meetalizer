class DashboardController < ApplicationController
  def index
    @groups = current_user.groups_as_admin
  end
end
