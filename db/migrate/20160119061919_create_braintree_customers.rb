class CreateBraintreeCustomers < ActiveRecord::Migration
  def change
    create_table :braintree_customers do |t|
      t.string :customer_id
      t.string :invited_plan_id
      t.string :subscription_id

      t.timestamps null: false
    end

    add_reference :users, :braintree_customer, index: true
  end
end
