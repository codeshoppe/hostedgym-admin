class Transaction
  include ::SimpleAttrs

  has_simple_attr :transaction_date
  has_simple_attr :id
  has_simple_attr :amount
end
