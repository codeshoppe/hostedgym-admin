class Users::RegistrationsController < Devise::RegistrationsController
  after_filter :sync_to_payment_service

  protected

  def sync_to_payment_service
    if resource.persisted?
      braintree_id = PaymentService::Vault.find_customer_id(resource.email)

      if braintree_id.blank?
        braintree_id = PaymentService::Vault.store_customer(resource.email, resource.first_name, resource.last_name)
      end

      if braintree_id.present?
        resource.create_braintree_customer!(customer_id: braintree_id)
      else
        raise Exception, 'Could not sync user to payment service'
      end
    end
  end
end
