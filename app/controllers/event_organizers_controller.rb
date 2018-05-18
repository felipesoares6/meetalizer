class EventOrganizersController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :update]
  before_action :find_group, only: [:create, :destroy]
  before_action :find_event, only: [:create, :destroy]
  before_action :find_user, only: [:create, :destroy]

  def create
    if @event.organizers << @user
      redirect_to group_event_path(group_id, event_id)
    else
      flash[:errors] = @organizer.errors.full_messages
    end
  end

  def destroy
    if @event.destroy.delete(@user)
      redirect_to group_event_path(group_id, event_id)
    else
      flash[:errors] = @organizer.errors.full_messages
    end
  end

  def find_group
    @group = Group.find_by!(id: params[:group_id])
  end

  def find_event
    @event = @group.events.find_by!(id: params[:event_id])
  end

  def find_user
    @user = User.find_by!(id: params[:id])
  end
end
