class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_group, only: [:index, :new, :create]

  def index
    @events = @group.events
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.group = @group

    if @event.save
      redirect_to root_path
    else
      flash[:errors] = @event.errors.full_messages
      render :new
    end
  end

  private
  def find_group
    @group = Group.find_by(id: params[:group_id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :address, :start_date, :end_date, :cover_picture_url)
  end
end
