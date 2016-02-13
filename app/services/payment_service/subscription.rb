module PaymentService
  module Subscription

    def self.create(payment_method, plan_id)
      PaymentService::safely_call do
        result = Braintree::Subscription.create(
          payment_method_nonce: payment_method,
          plan_id: plan_id
        )
        BraintreeSubscriptionAdapter.adapt(result.subscription) if result.success?
      end
    end

    def self.find(customer_id, subscription_id)
      PaymentService::safely_call do
        customer = Braintree::Customer.find(customer_id)
        server_subscription = customer.payment_methods.flat_map(&:subscriptions).detect do |subscription|
          subscription.id == subscription_id
        end

        BraintreeSubscriptionAdapter.adapt(server_subscription) if server_subscription
      end
    end
  end
end
