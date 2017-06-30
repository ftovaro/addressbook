require 'rails_helper'

RSpec.describe "Organizations", type: :request do
  describe "GET api/v1/organizations" do
    it "works! (now write some real specs)" do
      get api_v1_organizations_path
      expect(response).to have_http_status(200)
    end
  end
end
