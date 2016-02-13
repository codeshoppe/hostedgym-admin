class BraintreeTransactionAdapter
  def self.adapt(braintree_transaction)
    self.new(braintree_transaction).adapt
  end

  def initialize(braintree_transaction)
    @braintree_transaction = braintree_transaction
  end

  def adapt
    Transaction.new(
      transaction_date: transaction_date,
      id: id,
      amount: amount
    )
  end

  private
  def transaction_date
    @braintree_transaction.created_at
  end

  def id
    @braintree_transaction.id
  end

  def amount
    @braintree_transaction.amount
  end

end
