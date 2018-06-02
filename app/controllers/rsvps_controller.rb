class RsvpsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @rsvp = EventRsvp.find_or_initialize_by(
      user_id: current_user.id,
      event_id: params[:event_id]
    )
    @rsvp.answer = !@rsvp.answer

    flash[:errors] = @rsvp.errors.full_messages unless @rsvp.save

    redirect_to_event
  end

  private

  def redirect_to_event
    redirect_to group_event_path(params[:group_id], params[:event_id])
  end
end
