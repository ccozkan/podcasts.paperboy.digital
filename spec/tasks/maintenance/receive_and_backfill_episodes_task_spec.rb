# frozen_string_literal: true

require "rails_helper"

module Maintenance
  RSpec.describe ReceiveAndBackfillEpisodesTask do
    describe "#process" do
      subject(:process) { described_class.process(element) }
      let(:element) do
        # Object to be processed in a single iteration of this task
      end
      pending "add some examples to (or delete) #{__FILE__}"
    end
  end
end
