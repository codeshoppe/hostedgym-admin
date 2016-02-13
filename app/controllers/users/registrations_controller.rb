class Users::RegistrationsController < Devise::RegistrationsController
  after_filter :sync_to_payment_service

  protected

  def sync_to_payment_service
    if resource.persisted?
      resource.create_customer_account

      begin
        UserPaymentSync.new(resource).sync_customer!
      rescue PaymentService::PaymentServiceError => e
        Rails.error.log("New user could not sync to payment service, #{e} #{e.backtrace}")
      end
    end
  end
end
