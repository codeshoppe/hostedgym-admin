class DashboardController < ApplicationController
  before_action :skip_authorization
  before_action :skip_policy_scope

  def index
  end
end
