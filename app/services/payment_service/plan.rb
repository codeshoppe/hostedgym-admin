module PaymentService
  module Plan
    def self.all
      PaymentService::safely_call do
        Braintree::Plan.all.map do |plan|
          BraintreePlanAdapter.adapt(plan)
        end
      end
    end
  end
end
