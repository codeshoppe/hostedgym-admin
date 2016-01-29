class Users::RegistrationsController < Devise::RegistrationsController
  after_filter :sync_to_payment_service

  protected

  def sync_to_payment_service
    if resource.persisted?
      resource.braintree_customer.create!

      begin
        UserPaymentSync.new(resource).sync_customer!
      rescue PaymentServiceError => e
        Rails.error.log("New user could not sync to payment service, #{e} #{e.backtrace}")
      end
    end
  end
end
