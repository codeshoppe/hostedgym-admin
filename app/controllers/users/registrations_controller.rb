class Users::RegistrationsController < Devise::RegistrationsController
  after_filter :sync_to_payment_service

  protected

  def sync_to_payment_service
    UserPaymentSync.new(resource).sync! if resource.persisted?
  end
end
