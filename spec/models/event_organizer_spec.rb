require 'rails_helper'

RSpec.describe EventOrganizer, type: :model do
  it { is_expected.to belong_to :organizer }
  it { is_expected.to belong_to :organized_event }
end
