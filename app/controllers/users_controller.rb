class UsersController < ApplicationController
  def index
    @users = Group.find(params[:group_id]).users
  end
end
