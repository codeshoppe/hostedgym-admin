class AccountDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  delegate :customer_id, :invited_plan_id, :subscription_id, to: :braintree_customer

  def braintree_customer
    object.braintree_customer || object.create_braintree_customer!
  end
end
