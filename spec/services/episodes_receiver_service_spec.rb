require 'rails_helper'

RSpec.describe EpisodesReceiverService, type: :service do
  let(:valid_feed_url) { 'https://feeds.feedburner.com/ReverberationRadio'}
  let(:not_feed_url) { 'https://google.com' }
  let(:invalid_url) { 'invalid.url.hahaha' }

  describe 'when valid feed url' do
    let(:subject) { EpisodesReceiverService.new(valid_feed_url).call }

    it 'returns payload and success? as true' do
      expect(subject.success?).to eq true
      expect(subject.payload.present?).to eq true
      expect(subject.error.present?).to eq false
    end
  end

  describe 'when not feed url' do
    let(:subject) { EpisodesReceiverService.new(not_feed_url).call }

    it 'returns InvalidFeedUrl error and success? as false' do
      expect(subject.success?).to eq false
      expect(subject.payload.present?).to eq false
      expect(subject.error.present?).to eq true
      expect(subject.error.class).to eq EpisodesReceiverService::UrlIsNotFeed
      expect(subject.error.class).to be < StandardError
    end
  end

  describe 'when invalid url' do
    let(:subject) { EpisodesReceiverService.new(invalid_url).call }

    it 'returns Standard error and success? as false' do
      expect(subject.success?).to eq false
      expect(subject.payload.present?).to eq false
      expect(subject.error.present?).to eq true
      expect(subject.error.class).to be < StandardError
    end
  end
end
