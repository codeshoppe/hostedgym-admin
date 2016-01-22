class AccountsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize User
    @accounts = account_collection
  end

  def show
    @account = account_collection.find(params[:id])
    authorize @account
  end

  def edit
    @account = account_collection.find(params[:id])
    authorize @account
  end

  def update
    @account = account_collection.find(params[:id])
    authorize @account
    if @account.braintree_customer.update(update_params)
      redirect_to account_path(@account)
    else
      raise Exception
    end
  end

  private
  def account_collection
    @accounts ||= policy_scope(User)
  end

  def update_params
    params.require(:braintree_customer).permit(:invited_plan_id)
  end
end
