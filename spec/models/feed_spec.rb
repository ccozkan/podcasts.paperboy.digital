require 'rails_helper'

RSpec.describe Feed, type: :model do
  before do
    allow_any_instance_of(Feed).to receive(:catch_up_episodes).and_return(true)
  end

  describe 'model consistency' do
    it { is_expected.to have_many(:episodes).dependent(:destroy) }
    it { is_expected.to have_many(:subscriptions).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:subscriptions) }
    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_uniqueness_of(:external_id) }
    it { is_expected.to validate_presence_of(:rss_url) }
  end
end
