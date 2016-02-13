class Subscription
  include ::SimpleAttrs

  # Subscription Details
  has_simple_attr :id
  has_simple_attr :status
  has_simple_attr :days_past_due
  has_simple_attr :price

  # Billing Details
  has_simple_attr :first_billing_date
  has_simple_attr :billing_period_start_date
  has_simple_attr :billing_period_end_date
  has_simple_attr :paid_through_date
  has_simple_attr :balance
  has_simple_attr :next_billing_date
  has_simple_attr :next_billing_period_amount

  # Relationships
  has_simple_attr :transactions

end
