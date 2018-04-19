class UsersController < ApplicationController
  def index
    @users = params[:group_id]
    byebug
  end
end
