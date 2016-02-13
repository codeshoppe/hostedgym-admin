class BraintreeSubscriptionAdapter
  def self.adapt(braintree_subscription)
    self.new(braintree_subscription).adapt
  end

  def initialize(braintree_subscription)
    @braintree_subscription = braintree_subscription
  end

  def adapt
    transactions = (@braintree_subscription.transactions || []).map do |braintree_transaction|
      BraintreeTransactionAdapter.adapt(braintree_transaction)
    end

    attrs = { transactions: transactions }

    Subscription.simple_attrs.keys.each do |key|
      attrs[key] = @braintree_subscription.send(key) if attrs[key].blank?
    end

    Subscription.new(attrs)
  end
end
