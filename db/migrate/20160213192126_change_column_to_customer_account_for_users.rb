class ChangeColumnToCustomerAccountForUsers < ActiveRecord::Migration
  def change
    rename_column :users, :braintree_customer_id, :customer_account_id
  end
end
