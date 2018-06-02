require 'rails_helper'

RSpec.describe EventRsvp, type: :model do
  it { is_expected.to belong_to :rsvp }
  it { is_expected.to belong_to :answered_event }
end
