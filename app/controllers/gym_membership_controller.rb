class GymMembershipController < ApplicationController
  before_action :authenticate_user!

  before_action :skip_authorization
  before_action :skip_policy_scope

  def join_now
    @client_token = Braintree::ClientToken.generate(customer_id: braintree_customer.customer_id)
  end

  def checkout
    plan_id = braintree_customer.invited_plan_id
    nonce = params[:payment_method_nonce]
    result = Braintree::Subscription.create(
      payment_method_nonce: nonce,
      plan_id: "MONTHLY_PLAN_v1"
    )
    if result.success?
      braintree_customer.update_column(:subscription_id, result.subscription.id)
    end
    render json: {text: result.inspect}
  end

  private
  def braintree_customer
    current_user.braintree_customer
  end

end
