class EventPolicy
  attr_reader :user, :event

  def initialize(user, event)
    @user = user
    @event = event
  end

  def edit?
    organizer?
  end

  def update?
    organizer?
  end

  def destroy?
    organizer?
  end

  def rsvp?
    !organizer? && (!rsvp_yes? || !rsvp_no?)
  end

  def rsvp_with_yes?
    !organizer? && !rsvp_yes?
  end

  def rsvp_with_no?
    !organizer? && !rsvp_no?
  end

  private
  def organizer?
    @organizer ||= @event.organizers.where(id: @user.id).any?
  end

  def rsvp_yes?
    @rsvp_yes ||= @event.event_rsvps.where(user_id: @user.id, answer: true).any?
  end

  def rsvp_no?
    @rsvp_no ||= @event.event_rsvps.where(user_id: @user.id, answer: false).any?
  end
end
