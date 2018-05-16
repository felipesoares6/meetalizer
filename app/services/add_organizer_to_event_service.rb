class AddOrganizerToEventService
  def initialize(user, event)
    @user = user
    @event = event
  end

  def self.perform(user, event)
    instance = new(user, event)

    ActiveRecord::Base.transaction do
      instance.create_organizer
      instance.add_organizer_to_event
    end
  end

  def create_organizer
    @organizer = Organizer.new(user_id: @user.id, event_id: @event.id)
  end

  def add_organizer_to_event
    @event.organizers << @organizer
  end
end
