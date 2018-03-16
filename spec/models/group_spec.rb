require 'rails_helper'

RSpec.describe Group, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :region }
  it { is_expected.to validate_length_of(:description).is_at_most(130) }
end
