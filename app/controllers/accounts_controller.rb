class AccountsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_account, only: [:show, :edit, :update]

  def index
    authorize User
    @accounts = account_collection
  end

  def show
  end

  def edit
    @plans = Payment::PlanDecorator.decorate_collection(PaymentService::Plan.all)
  end

  def update
    begin
      braintree_customer.with_lock do
        if braintree_customer.subscription_id.blank?
          if braintree_customer.update(update_params)
            flash[:success] = "Successful update."
          else
            flash[:error] = "Could not update."
          end
        else
          flash[:error] = "This user has already accepted this invitation."
        end
      end
    rescue StandardError
      flash[:error] = "Could not update."
    end

    redirect_to account_path(@account)
  end

  private
  def account_collection
    @accounts ||= policy_scope(User)
  end

  def update_params
    params.require(:braintree_customer).permit(:invited_plan_id)
  end

  def set_account
    @account = account_collection.find(params[:id])
    authorize @account
  end

  def braintree_customer
    @account.braintree_customer
  end
end
