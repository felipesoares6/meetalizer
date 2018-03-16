class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :delete]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.users = [current_user]

    if @group.valid?
      @group.save

      redirect_to groups_path
    else
      flash[:errors] = @group.errors.full_messages
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.update(group_params)

    if @group.valid?
      @group.save

      redirect_to groups_path
    else
      flash[:errors] = @group.errors.full_messages
      render :edit
    end
  end

  def delete
    @group = Group.find(params[:id])

    if @group.valid?
      @group.destroy

      redirect_to groups_path
    else
      flash[:errors] = @group.erros.full_messages
    end
  end

  def group_params
    params.require(:group).permit(:name, :description, :region)
  end
end
