class CreateCustomerAccounts < ActiveRecord::Migration
  def change
    create_table :customer_accounts do |t|
      t.integer :customer_id
      t.string :invited_plan_id
      t.string :subscription_id
      t.string :type

      t.timestamps null: false
    end
  end
end
