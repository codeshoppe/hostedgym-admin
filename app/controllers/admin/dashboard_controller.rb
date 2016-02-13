class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin!

  before_action :skip_authorization
  before_action :skip_policy_scope
  def index
  end
end
