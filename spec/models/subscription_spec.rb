require 'rails_helper'

RSpec.describe Subscription, type: :model do
  let(:user) { create(:user) }
  let(:feed) { create(:feed) }
  let(:subscription) { create(:subscription, feed_id: feed.id, user_id: user.id) }

  before do
    allow_any_instance_of(Feed).to receive(:catch_up_episodes).and_return(true)
    subscription
  end

  describe 'model consistency' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:feed) }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:feed_id) }
  end
end
