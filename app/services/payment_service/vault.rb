module PaymentService
  class Vault < Base
    def self.store_customer(email, first_name, last_name)
      safely_call do
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
      safely_call do
        collection = Braintree::Customer.search do |search|
          search.email.is email
        end
        collection.first.id if collection.any?
      end
    end
  end
end
