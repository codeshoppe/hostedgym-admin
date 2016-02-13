class CreateCustomerAccounts < ActiveRecord::Migration
  def change
    rename_table :braintree_customers, :customer_accounts
  end
end
