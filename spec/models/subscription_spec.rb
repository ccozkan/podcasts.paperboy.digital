require 'rails_helper'

RSpec.describe Subscription, type: :model do
  let(:user) { create(:user) }
  let(:feed) { create(:feed) }
  let!(:subscription) { create(:subscription, feed_id: feed.id, user_id: user.id) }

  describe 'model consistency' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:feed) }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:feed_id) }
  end
end
