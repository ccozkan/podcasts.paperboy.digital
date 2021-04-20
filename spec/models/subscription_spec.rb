require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'model consistency' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:feed) }
  end
end
