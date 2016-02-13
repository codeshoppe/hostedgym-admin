class DashboardController < ApplicationController
  before_action :skip_authorization
  before_action :skip_policy_scope

  before_action :authenticate_user!

  before_action do
    redirect_to admin_dashboard_path if current_user.admin?
  end

  def index
  end
end
