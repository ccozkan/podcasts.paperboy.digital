require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'model consistency' do
    it { is_expected.to have_many(:subscriptions).dependent(:destroy) }
    it { is_expected.to have_many(:interactions).dependent(:destroy) }
    it { is_expected.to have_many(:feeds).through(:subscriptions) }
    it { is_expected.to have_many(:episodes).through(:interactions) }
  end

  describe '.find_or_create_from_provider_data' do
    context 'github' do
      let!(:provider_data) { OmniAuth::AuthHash.new(provider: 'github', uid: 'abc123xyz', info: OmniAuth::AuthHash.new(email: 'jamesbond@double-o-seven.com')) }
      context 'new user' do
        it do
          expect(User.find_or_create_from_provider_data(provider_data).class).to eq User
        end

        it do
          expect(User.find_by(email: 'jamesbond@double-o-seven.com')).to eq nil
          User.find_or_create_from_provider_data(provider_data)
          expect(User.find_by(email: 'jamesbond@double-o-seven.com')).not_to eq nil
          expect(User.find_by(email: 'jamesbond@double-o-seven.com').confirmed?).to eq true
        end
      end

      context 'not new user' do
        it do
          user_from_first_run = User.find_or_create_from_provider_data(provider_data)
          user_from_second_run = User.find_or_create_from_provider_data(provider_data)
          expect(user_from_first_run).to eq user_from_second_run
        end
      end
    end
  end
end
