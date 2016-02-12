module PaymentService
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
