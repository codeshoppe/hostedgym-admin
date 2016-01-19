class PaymentService

  class Vault
    def self.store_customer(email, first_name, last_name)
      sync_attrs = {
        email: email,
        first_name: first_name,
        last_name: last_name
      }

      result = Braintree::Customer.create(sync_attrs)
      result.customer.id if result.success?
    end
  end

end
