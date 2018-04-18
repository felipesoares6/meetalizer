class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @can_update = policy(@group).update?
    @can_destroy = policy(@group).destroy?
    @can_become_member = policy(@group).become_member?
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    AddMembershipToGroupService.perform(current_user, @group)

    if @group.save
      redirect_to root_path
    else
      flash[:errors] = @group.errors.full_messages
      render :new
    end
  end

  def edit
    authorize @group
  end

  def update
    authorize @group

    if @group.update(group_params)
      redirect_to group_path(@group)
    else
      flash[:errors] = @group.errors.full_messages
      render :edit
    end
  end

  def destroy
    authorize @group

    if @group.destroy
      redirect_to root_path
    else
      flash[:errors] = @group.errors.full_messages
      render :show
    end
  end

  private
  def find_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :region, :profile_picture_url, :cover_picture_url)
  end
end
