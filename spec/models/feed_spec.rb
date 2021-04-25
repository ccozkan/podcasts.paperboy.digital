require 'rails_helper'

RSpec.describe Feed, type: :model do
  describe 'model consistency' do
    it { is_expected.to have_many(:episodes) }
    it { is_expected.to have_many(:subscriptions) }
    it { is_expected.to have_many(:users).through(:subscriptions) }
    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_uniqueness_of(:external_id) }
  end
end
