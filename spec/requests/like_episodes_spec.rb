require 'rails_helper'

RSpec.describe "LikeEpisodes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/like_episodes/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/like_episodes/update"
      expect(response).to have_http_status(:success)
    end
  end

end
