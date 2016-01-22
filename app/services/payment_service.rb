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
    def self.create(customer_id, payment_method)
      BraintreeCustomer.transaction do
        customer = BraintreeCustomer.where(customer_id: customer_id, subscription_id: nil).lock(true).first
        if customer
          plan_id = customer.invited_plan_id

          result = Braintree::Subscription.create(
            payment_method_nonce: payment_method,
            plan_id: plan_id
          )

          customer.update(subscription_id: result.subscription.id) if result.success?
        end
      end
    end
  end

end
