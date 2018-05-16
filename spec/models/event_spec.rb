require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :address }
  it { is_expected.to validate_presence_of :start_date }
  it { is_expected.to validate_presence_of :end_date }
  it { is_expected.to have_many :organizers }
  it { is_expected.to have_many :users }
end
