require 'rails_helper'

RSpec.describe Library do
  subject(:library) { build(:library) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:lat) }
  it { is_expected.to validate_presence_of(:lng) }
end
