class EventsController < ApplicationController
  def index
    @events = Group.find(params[:group_id]).events
  end
end
