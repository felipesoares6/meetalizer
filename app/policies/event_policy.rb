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

  def rsvp_with_yes?
    !organizer?
  end

  def rsvp_with_no?
    !organizer?
  end

  private
  def organizer?
    @organizer ||= @event.organizers.where(id: @user.id).any?
  end
end
