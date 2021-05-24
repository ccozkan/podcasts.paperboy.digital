require 'rails_helper'

RSpec.describe Episode, type: :model do
  describe 'model consistency' do
    let(:feed) { create(:feed) }
    let!(:episode) { create(:episode, feed_id: feed.id) }

    it { is_expected.to belong_to(:feed) }
    it { is_expected.to validate_presence_of(:external_id) }
    it { is_expected.to validate_uniqueness_of(:external_id) }
    it { is_expected.to validate_presence_of(:audio_url) }
    it { is_expected.to have_many(:interactions) }
  end
end
