class BraintreePlanAdapter

  def self.adapt(braintree_plan)
    self.new(braintree_plan).adapt
  end

  def initialize(braintree_plan)
    @braintree_plan = braintree_plan
  end

  def adapt
    attributes = Plan.simple_attrs.keys.inject({}) do |result, key|
      result[key] = @braintree_plan.send(key)
      result
    end

    Plan.new(attributes)
  end
end
