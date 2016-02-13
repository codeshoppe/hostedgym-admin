require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  describe "GET #index" do
    context 'as user' do
      login_user
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context 'as admin' do
      login_admin
      it "redirects to admin dashboard" do
        get :index
        expect(response).to redirect_to(admin_dashboard_path)
      end
    end
  end

end
