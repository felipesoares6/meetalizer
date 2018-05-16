class OrganizersController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :update]

  def create
    group_id = params[:group_id]
    event_id = params[:event_id]

    @organizer = Organizer.new(
      user_id: current_user.id,
      event_id: event_id,
    )

    if @organizer.save
      redirect_to group_event_path(group_id, event_id)
    else
      flash[:errors] = @organizer.errors.full_messages
    end
  end

  def update
    group_id = params[:group_id]
    event_id = params[:event_id]

    @organizer = Organizer.find_by(
      user_id: current_user.id,
      event_id: event_id
    )

    if @organizer.update
      redirect_to group_event_path(group_id, event_id)
    else
      flash[:errors] = @organizer.errors.full_messages
    end
  end
end
