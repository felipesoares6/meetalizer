class RsvpsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    event_id = params[:event_id]

    @rsvp = EventRsvp.find_or_initialize_by(
      user_id: current_user.id,
      event_id: event_id
    )

    @rsvp.answer = !@rsvp.answer

    if @rsvp.save
      redirect_to group_event_path(params[:group_id], event_id)
    else
      flash[:errors] = @rsvp.errors.full_messages
    end
  end

  private

  def rsvp_params
    params.require(:rsvp).permit(:answer)
  end
end
