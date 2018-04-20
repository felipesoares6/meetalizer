class UsersController < ApplicationController
  def index
    @members = params[:group_id]
  end
end
