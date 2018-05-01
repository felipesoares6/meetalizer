class MembersController < ApplicationController
  def index
    @members = Group.find(params[:group_id]).users
  end
end
