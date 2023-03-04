require "rails_helper"

RSpec.describe FeedSearcherService, type: :service do
  describe "#call" do
    let(:subject) { FeedSearcherService.new("reverberation radio").call }

    it "should find some shows" do
      expect(subject.length).to be > 0
    end

    it "should return proper format" do
      expect(subject.class).to eq Array
      expect(subject.first.class).to eq Hash
      expect(subject.first[:rss_url]).not_to eq nil
      expect(subject.first[:external_id]).not_to eq nil
      expect(subject.first[:pic_url]).not_to eq nil
      expect(subject.first[:provider]).not_to eq nil
      expect(subject.first[:name]).not_to eq nil
    end
  end
end
