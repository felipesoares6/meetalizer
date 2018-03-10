require 'rails_helper'

RSpec.describe User, type: :model do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :date_of_birth }
    it { is_expected.to validate_length_of(:bio).is_at_most(140) }
end
