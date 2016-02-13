class UserPaymentSync

  class NoInvitation < StandardError;end


  def initialize(user)
    @user = user
  end

  def sync_customer!
    customer_account = user.customer_account || user.build_customer_account

    if customer_account.customer_id.blank?
      customer_id = PaymentService::Vault.find_customer_id(user.email)
      customer_id = PaymentService::Vault.store_customer(user.email, user.first_name, user.last_name) if customer_id.blank?

      customer_account.customer_id = customer_id
    end

    customer_account.save
  end

  def create_subscription!(payment_method)
    CustomerAccount.transaction do
      customer_account_id = user.customer_account.customer_id

      customer_account = CustomerAccount.where(customer_id: customer_account_id, subscription_id: nil).lock(true).first

      if customer_account
        plan_id = customer_account.invited_plan_id

        raise NoInvitation, "User[#{user.id}] - No invitation" if plan_id.blank?

        subscription = PaymentService::Subscription.create(payment_method, plan_id)
        customer_account.update(subscription_id: subscription.id) if subscription.present?
      end
    end
  end

  private
  attr_reader :user
end
