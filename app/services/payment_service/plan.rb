module PaymentService
  class Plan < Base
    def self.all
      safely_call do
        Braintree::Plan.all.map do |plan|
          BraintreePlanAdapter.adapt(plan)
        end
      end
    end
  end
end
