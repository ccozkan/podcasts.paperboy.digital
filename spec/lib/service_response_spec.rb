require "rails_helper"

RSpec.describe ServiceResponse, type: :lib do
  describe "when valid" do
    context "when successfull" do
      let(:subject) { ServiceResponse.new(payload: 42, error: nil) }

      it { expect(subject.success?).to eq true }
    end

    context "when unsuccessfull" do
      let(:subject) { ServiceResponse.new(payload: nil, error: "ImAnErrorLOL") }

      it { expect(subject.success?).to eq false }
    end
  end
end
