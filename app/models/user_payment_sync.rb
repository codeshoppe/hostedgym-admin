class UserPaymentSync

  class NoInvitation < StandardError;end


  def initialize(user)
    @user = user
  end

  def sync_customer!
    braintree_customer = user.braintree_customer || user.build_braintree_customer

    if braintree_customer.customer_id.blank?
      customer_id = PaymentService::Vault.find_customer_id(user.email)
      customer_id = PaymentService::Vault.store_customer(user.email, user.first_name, user.last_name) if customer_id.blank?

      braintree_customer.customer_id = customer_id
    end

    braintree_customer.save
  end

  def create_subscription!
    BraintreeCustomer.transaction do
      braintree_customer = BraintreeCustomer.where(customer_id: customer_id, subscription_id: nil).lock(true).first
      if braintree_customer
        plan_id = braintree_customer.invited_plan_id

        raise NoInvitation, "User[#{user.id}] - No invitation" if plan_id.blank?

        result = PaymentService::Subscription.create(payment_method_nonce: payment_method, plan_id: plan_id)
        braintree_customer.update(subscription_id: result.subscription.id) if result.success?
      end
    end
  end

  private
  attr_reader :user
end
