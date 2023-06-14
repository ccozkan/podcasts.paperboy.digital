require 'rails_helper'

RSpec.describe "BackgroundProcesses", type: :request do
  describe "GET /controller" do
    it "returns http success" do
      get "/background_processes/controller"
      expect(response).to have_http_status(:success)
    end
  end

end
