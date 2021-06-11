require 'rails_helper'

RSpec.describe Interaction, type: :model do
  let!(:user) { create(:user) }
  let(:feed) { create(:feed) }
  let(:episode) { create(:episode, feed_id: feed.id) }

  before do
    allow_any_instance_of(Feed).to receive(:catch_up_episodes).and_return(true)
    episode
  end

  describe 'model consistency' do
    let!(:interaction) { create(:interaction, user_id: user.id, episode_id: episode.id)}

    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:episode) }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:episode_id) }
  end

  describe '.dismiss_an_episode' do
    it { expect(user.interactions).to eq [] }
    it do
      Interaction.dismiss_an_episode(episode.id, user.id)

      expect(user.interactions).not_to eq []
      expect(user.interactions.first.episode_id).to eq episode.id
      expect(user.interactions.first.dismissed).to eq true
    end
  end
end
