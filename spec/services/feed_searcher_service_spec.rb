require "rails_helper"

RSpec.describe FeedSearcherService, type: :service do
  describe "#call" do
    let(:subject) { FeedSearcherService.new("reverberation radio").call }

    it "should find some shows" do
      expect(subject.payload.length).to be > 0
    end

    it "should return proper format" do
      expect(subject.class).to eq ServiceResponse
      expect(subject.payload.class).to eq Array
      expect(subject.payload.first[:rss_url]).not_to eq nil
      expect(subject.payload.first[:external_id]).not_to eq nil
      expect(subject.payload.first[:pic_url]).not_to eq nil
      expect(subject.payload.first[:provider]).not_to eq nil
      expect(subject.payload.first[:name]).not_to eq nil
    end
  end
end
