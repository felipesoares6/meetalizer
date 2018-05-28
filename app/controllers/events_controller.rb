class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_group, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :find_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = @group.events
  end

  def show
    @can_update = policy(@event).update?
    @can_destroy = policy(@event).destroy?
    @can_rsvp = policy(@event).rsvp?
    @can_rsvp_with_yes = policy(@event).rsvp_with_yes?
    @can_rsvp_with_no = policy(@event).rsvp_with_no?
  end

  def new
    @event = Event.new(group_id: @group.id)

    authorize @event
  end

  def create
    authorize @event

    @event = Event.new(event_params)

    @event.group = @group
    @event.organizers << current_user

    if @event.save
      redirect_to group_event_path(@group, @event)
    else
      flash[:errors] = @event.errors.full_messages
      render :new
    end
  end

  def edit
    authorize @event
  end

  def update
    authorize @event

    if @event.update(event_params)
      redirect_to group_event_path(@group, @event)
    else
      flash[:errors] = @event.errors.full_messages
      render :edit
    end
  end

  def destroy
    authorize @event

    if @event.destroy
      redirect_to group_path(@group)
    else
      flash[:errors] = @event.errors.full_messages
      render :show
    end
  end

  private
  def find_group
    @group = Group.find_by!(id: params[:group_id])
  end

  def find_event
    @event = @group.events.find_by!(id: params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :address, :start_date, :end_date, :cover_picture_url)
  end
end
