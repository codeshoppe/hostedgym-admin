class MembershipsController < ApplicationController
  before_action :authenticate_user!

  before_action :skip_authorization
  before_action :skip_policy_scope

  include PaymentServiceable

  def new
    if policy(:membership).new?
      @client_token = Braintree::ClientToken.generate(customer_id: customer_account.customer_id)
    else
      redirect_to membership_path, notice: "You already have a membership."
    end
  end

  def show
    @subscription = PaymentService::Subscription.find(customer_account.customer_id, customer_account.subscription_id) if current_user.gym_member?
  end

  def create
    authorize(:membership, :create?)
    payment_method = params[:payment_method_nonce]

    if payment_method.blank?
      flash[:error] = "Invalid payment method."
      raise Exception
    end

    success = UserPaymentSync.new(current_user).create_subscription!(payment_method)

    if !!success
      redirect_to membership_path, notice: "Success!"
    else
      flash[:error] = "Could not create subscription, please contact the admin."
      render :new
    end
  end

  private
  def customer_account
    current_user.customer_account
  end

end
