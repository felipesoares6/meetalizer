require 'rails_helper'

RSpec.describe Membership, type: :model do
  it { is_expected.to validate_presence_of :user_id }
  it { is_expected.to validate_presence_of :role }
  it { is_expected.to define_enum_for(:role).with([:admin, :normal]) }
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :group }
end
