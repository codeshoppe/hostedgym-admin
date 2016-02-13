module PaymentService
  module Vault
    class EmailAddressNotUniqueError < StandardError; end

    def self.store_customer(email, first_name, last_name)
      PaymentService::safely_call do
        sync_attrs = {
          email: email,
          first_name: first_name,
          last_name: last_name
        }
        result = Braintree::Customer.create(sync_attrs)
        result.customer.id if result.success?
      end
    end

    def self.find_customer_id(email)
      PaymentService::safely_call do
        collection = Braintree::Customer.search do |search|
          search.email.is email
        end

        if collection.count == 1
          collection.first.id
        elsif collection.count > 1
          raise EmailAddressNotUniqueError, "Email: #{email}"
        end
      end
    end
  end
end
