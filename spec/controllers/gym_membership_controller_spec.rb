require 'rails_helper'

RSpec.describe GymMembershipController, type: :controller do

  describe "GET #join_now" do
    it "returns http success" do
      get :join_now
      expect(response).to have_http_status(:success)
    end
  end

end
