class Users::RegistrationsController < Devise::RegistrationsController
  after_filter :add_account

  protected

  def add_account
    if resource.persisted?
      braintree_id = PaymentService::Vault.find_customer_id(resource.email)
      if braintree_id.present?
        resource.create_braintree_customer(customer_id: braintree_id)
      else
        sync_to_payment_service(resource)
      end
    end
  end

  def sync_to_payment_service(resource)
    customer_id = PaymentService::Vault.store_customer(resource.email, resource.first_name, resource.last_name)
    if customer_id.present?
      resource.create_braintree_customer!(customer_id: customer_id)
    else
      raise Exception, 'Could not sync user to payment service'
    end
  end
end
