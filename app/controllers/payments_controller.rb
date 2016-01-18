class PaymentsController < ApplicationController
  def index
    # TODO: retrieve customer id
    @client_token = Braintree::ClientToken.generate(customer_id: "")
  end

  def checkout
    nonce = params[:payment_method_nonce]
    puts params.inspect

    result = Braintree::Subscription.create(
      payment_method_nonce: nonce,
      plan_id: "MONTHLY_PLAN_v1"
    )
    render json: {text: result.inspect}
  end
end
