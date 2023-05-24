require "rails_helper"

RSpec.describe Interaction, type: :model do
  let!(:user) { create(:user) }
  let(:feed) { create(:feed) }
  let(:episode) { create(:episode, feed_id: feed.id) }

  describe "model consistency" do
    let!(:interaction) { create(:interaction, user_id: user.id, episode_id: episode.id) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:episode) }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:episode_id) }
  end

  describe ".dismiss!" do
    it { expect(user.interactions).to eq [] }
    it do
      Interaction.dismiss!(episode.id, user.id)

      expect(user.interactions).not_to eq []
      expect(user.interactions.first.episode_id).to eq episode.id
      expect(user.interactions.first.dismissed).to eq true
    end

    it "dismisses listen-it-later episode" do
      Interaction.toggle_from_listen_it_later!(episode.id, user.id)
      Interaction.dismiss!(episode.id, user.id)

      expect(user.interactions.first.dismissed).to eq true
    end
  end

  describe ".toggle_from_listen_it_later" do
    it "later an episode" do
      Interaction.toggle_from_listen_it_later!(episode.id, user.id)

      expect(user.interactions.first.listen_it_latered_at).not_to eq nil
    end

    it "unlater an episode" do
      Interaction.toggle_from_listen_it_later!(episode.id, user.id)
      Interaction.toggle_from_listen_it_later!(episode.id, user.id)

      expect(user.interactions.first.listen_it_latered_at).to eq nil
    end

    it "later and then unlater an episode" do
      Interaction.toggle_from_listen_it_later!(episode.id, user.id)
      Interaction.toggle_from_listen_it_later!(episode.id, user.id)
      Interaction.toggle_from_listen_it_later!(episode.id, user.id)

      expect(user.interactions.first.listen_it_latered_at).not_to eq nil
    end
  end
end
