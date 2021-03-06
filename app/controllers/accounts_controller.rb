class AccountsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_account, only: [:show, :edit, :update]

  def index
    authorize User
    @accounts = AccountDecorator.decorate_collection(account_collection)
  end

  def show
  end

  def edit
    @plans = Payment::PlanDecorator.decorate_collection(PaymentService::Plan.all)
  end

  def update
    begin
      customer_account.with_lock do
        if customer_account.subscription_id.blank?
          if customer_account.update(update_params)
            flash[:success] = "Successful update."
          else
            flash[:error] = "Could not update."
          end
        else
          flash[:error] = "This user already has a membership."
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
    params.require(:customer_account).permit(:invited_plan_id)
  end

  def set_account
    @account = account_collection.find(params[:id])
    authorize @account
    sync_user_to_payment_service(@account)
    @account = AccountDecorator.decorate(@account)
  end

  def customer_account
    @account.customer_account
  end
end
