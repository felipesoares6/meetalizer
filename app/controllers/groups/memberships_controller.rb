class MembershipsController < ApplicationController
  def create
    @membership = Membership.new(
      user_id: current_user.id,
      group_id: params[:group_id],
      role: :member
    )

    if @membership.save
      redirect_to root_path
    else
      flash[:errors] = @membership.errors.full_messages
    end
  end
end
