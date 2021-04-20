require 'rails_helper'

RSpec.describe Feed, type: :model do
  describe 'model consistency' do
    it { is_expected.to have_many(:episodes) }
  end
end
