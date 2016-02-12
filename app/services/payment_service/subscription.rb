module PaymentService
  class Subscription < Base
    include ::SimpleAttrs

    has_simple_attr :first_billing_date
    has_simple_attr :next_billing_date
    has_simple_attr :billing_period_start_date
    has_simple_attr :billing_period_end_date
    has_simple_attr :paid_through_date
    has_simple_attr :balance
    has_simple_attr :price
    has_simple_attr :status
    has_simple_attr :next_billing_period_amount
    has_simple_attr :days_past_due

    def self.create(payment_method, plan_id)
      safely_call do
        Braintree::Subscription.create(
          payment_method_nonce: payment_method,
          plan_id: plan_id
        )
      end
    end

    def self.find(customer_id, subscription_id)
      safely_call do
        customer = Braintree::Customer.find(customer_id)
        server_subscription = customer.payment_methods.flat_map(&:subscriptions).detect do |subscription|
          subscription.id == subscription_id
        end
        self.new_from_server(server_subscription) if server_subscription
      end
    end

    def self.new_from_server(server_subscription)
      values = self.simple_attrs.keys.map {|attr_name| [attr_name, server_subscription.send(attr_name)] }
      self.new(Hash[values])
    end
  end
end
