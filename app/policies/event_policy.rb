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

  def rsvp?
    !organizer? && (!rsvp_yes? || !rsvp_no?)
  end

  def rsvp_with_yes?
    !organizer? && !rsvp_yes? && !@event.full?
  end

  def rsvp_with_no?
    !organizer? && !rsvp_no?
  end

  private
  def admin?
    @admin ||= @event.group.admin?(@user)
  end

  def organizer?
    @organizer ||= @event.organizer?(@user)
  end

  def rsvp_yes?
    @rsvp_yes ||= @event.rsvp_answer?(@user)
  end

  def rsvp_no?
    @rsvp_no ||= !@event.rsvp_answer?(@user)
  end
end
