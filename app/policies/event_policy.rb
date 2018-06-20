class EventPolicy
  attr_reader :user, :event

  def initialize(user, event)
    @user = user
    @event = event
  end

  def new?
    admin?
  end

  def create?
    admin?
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
    !organizer? && !rsvp_answer? && !@event.full?
  end

  def rsvp_with_no?
    !organizer? && rsvp_answer?
  end

  private

  def admin?
    @admin ||= @event.group.admin?(@user)
  end

  def organizer?
    @organizer ||= @event.organizer?(@user)
  end

  def rsvp_answer?
    @rsvp ||= @event.rsvp_answer(@user)
  end
end
