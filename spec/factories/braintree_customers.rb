FactoryGirl.define do
  factory :braintree_customer do

    sequence :customer_id do |n|
      "customer_id_#{n}"
    end

    sequence :subscription_id do |n|
      "subscription_id_#{n}"
    end
  end

end
