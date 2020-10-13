require 'rails_helper'

RSpec.describe "Versions", type: :request do

  describe "GET /restore" do
    it "returns http success" do
      get "/versions/restore"
      expect(response).to have_http_status(:success)
    end
  end

end
