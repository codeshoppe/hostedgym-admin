module PaymentService
  class PaymentServiceError < ::StandardError; end

  class Base
    def self.safely_call(&block)
      begin
        yield
      rescue Braintree::BraintreeError => error
        Rails.logger.error("BraintreeError: #{error.message}\n#{error.backtrace}")
        raise PaymentServiceError, error.class.name.demodulize
      end
    end
  end

  class Vault < Base
    def self.store_customer(email, first_name, last_name)
      safely_call do
        sync_attrs = {
          email: email,
          first_name: first_name,
          last_name: last_name
        }

        result = Braintree::Customer.create(sync_attrs)
        result.customer.id if result.success?
      end
    end
  end

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

    def self.create(customer_id, payment_method)
      safely_call do
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

    def self.find(customer_id, subscription_id)
      customer = Braintree::Customer.find(customer_id)
      server_subscription = customer.payment_methods.flat_map(&:subscriptions).detect do |subscription|
        subscription.id == subscription_id
      end
      self.new_from_server(server_subscription) if server_subscription
    end

    def self.new_from_server(server_subscription)
      values = self.simple_attrs.keys.map {|attr_name| [attr_name, server_subscription.send(attr_name)] }
      self.new(Hash[values])
    end
  end

  class Plan < Base
    include ::SimpleAttrs

    has_simple_attr :id
    has_simple_attr :price
    has_simple_attr :billing_frequency

    def self.all
      safely_call do
        Braintree::Plan.all.map do |plan|
          self::new(id: plan.id, price: plan.price, billing_frequency: plan.billing_frequency)
        end
      end
    end
  end
end
