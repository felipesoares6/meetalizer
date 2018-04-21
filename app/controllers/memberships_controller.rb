class MembershipsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :destroy]

  def create
    group_id = params[:group_id]

    @membership = Membership.new(
      user_id: current_user.id,
      group_id: group_id,
      role: :normal
    )

    if @membership.save
      redirect_to group_path(group_id)
    else
      flash[:errors] = @membership.errors.full_messages
    end
  end

  def destroy
    group_id = params[:group_id]

    @membership = Membership.find_by(
      user_id: current_user.id,
      group_id: group_id
    )

    if @membership.destroy
      redirect_to group_path(group_id)
    else
      flash[:errors] = @membership.errors.full_messages
    end
  end
end
