require 'rails_helper'

RSpec.describe "PeekFeeds", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/peek_feeds/show"
      expect(response).to have_http_status(:success)
    end
  end

end
