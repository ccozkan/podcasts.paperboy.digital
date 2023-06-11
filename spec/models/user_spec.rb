require "rails_helper"

RSpec.describe User, type: :model do
  describe "model consistency" do
    it { is_expected.to have_many(:subscriptions).dependent(:destroy) }
    it { is_expected.to have_many(:interactions).dependent(:destroy) }
    it { is_expected.to have_many(:feeds).through(:subscriptions) }
    it { is_expected.to have_many(:episodes).through(:interactions) }
    it { is_expected.to validate_uniqueness_of(:email).scoped_to(:provider) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:email) }
  end

  describe ".find_or_create_from_provider_data" do
    let!(:provider_data) { OmniAuth::AuthHash.new(provider: "github", uid: "abc123xyz", info: OmniAuth::AuthHash.new(email: "jamesbond@double-o-seven.com")) }

    context "when new user" do
      it "creates a new user" do
        expect(User.find_by(email: "jamesbond@double-o-seven.com")).to eq nil
        user = User.find_or_create_from_provider_data(provider_data)

        expect(user.class).to eq User
        expect(User.find_by(email: "jamesbond@double-o-seven.com")).not_to eq nil
        expect(User.find_by(email: "jamesbond@double-o-seven.com").confirmed?).to eq true
      end

      it "creates a new user when same email is used for email-pwd user" do
        prev_user = create(:user, email: provider_data.info.email)
        user = User.find_or_create_from_provider_data(provider_data)

        expect(prev_user).not_to eq user
        expect(prev_user.email).to eq user.email
      end

      it "creates email-pwd user when same email is used for omniauth user" do
        prev_user = User.find_or_create_from_provider_data(provider_data)
        user = create(:user, email: provider_data.info.email)

        expect(prev_user).not_to eq user
        expect(prev_user.email).to eq user.email
      end
    end

    context "when not new user" do
      it "when previous user is created from oauth" do
        user_from_first_run = User.find_or_create_from_provider_data(provider_data)
        user_from_second_run = User.find_or_create_from_provider_data(provider_data)

        expect(user_from_first_run).to eq user_from_second_run
      end
    end
  end
end
