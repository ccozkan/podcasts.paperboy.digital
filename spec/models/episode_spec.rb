require 'rails_helper'

RSpec.describe Episode, type: :model do
  describe 'model consistency' do
    let(:feed) { create(:feed) }
    let(:episode) { create(:episode, feed_id: feed.id) }

    before do
      allow_any_instance_of(Feed).to receive(:catch_up_episodes).and_return(true)
      episode
    end

    it { is_expected.to belong_to(:feed) }
    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_uniqueness_of(:external_id) }
    it { is_expected.to validate_presence_of(:audio_url) }
    it { is_expected.to have_many(:interactions) }
  end
end
