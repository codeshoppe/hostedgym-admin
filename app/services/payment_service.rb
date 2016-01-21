class PaymentService

  class Vault
    def self.store_customer(email, first_name, last_name)
      sync_attrs = {
        email: email,
        first_name: first_name,
        last_name: last_name
      }

      result = Braintree::Customer.create(sync_attrs)
      result.customer.id if result.success?
    end
  end

  class Subscription
    def self.create(user, payment_method)
      plan_id = braintree_customer.invited_plan_id

      result = Braintree::Subscription.create(
        payment_method_nonce: payment_method,
        plan_id: plan_id
      )

      if result.success?
        user.braintree_customer.update(subscription_id: result.subscription.id)
        true
      else
        false
      end
    end
  end

end
