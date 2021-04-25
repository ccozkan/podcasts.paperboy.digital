require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'model consistency' do
    it { is_expected.to have_many(:subscriptions) }
    it { is_expected.to have_many(:feeds).through(:subscriptions) }
  end
end
