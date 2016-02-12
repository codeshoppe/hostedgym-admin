module PaymentServiceable
  extend ActiveSupport::Concern

  included do
    before_action do
      sync_user_to_payment_service(current_user)
    end
  end
end
