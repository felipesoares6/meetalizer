class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_group, only: [:index, :show, :new, :create, :edit, :update]
  before_action :find_event, only: [:show, :edit, :update]

  def index
    @events = @group.events
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.group = @group

    if @event.save
      render :show
    else
      flash[:errors] = @event.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to group_event_path(@group, @event)
    else
      flash[:errors] = @event.errors.full_messages
      render :edit
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
