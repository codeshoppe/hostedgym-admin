class CreateBraintreeCustomers < ActiveRecord::Migration
  def change
    create_table :braintree_customers do |t|
      t.references :user, index: true, foreign_key: true
      t.string :customer_id
      t.string :subscription_id

      t.timestamps null: false
    end
  end
end
