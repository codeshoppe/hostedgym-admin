module PaymentServiceable
  extend ActiveSupport::Concern

  included do
    before_action :sync_user_to_payment_service
  end

  protected

  def sync_user_to_payment_service
    UserPaymentSync.new(current_user).sync!
  end
end
