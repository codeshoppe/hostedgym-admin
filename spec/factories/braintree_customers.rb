FactoryGirl.define do
  factory :braintree_customer do

    factory :braintree_customer_synced do
      customer_id "existing_customer_id"

      factory :braintree_customer_invited do
        invited_plan_id "fake_plan_id"

        factory :braintree_customer_gym_member do
          subscription_id "existing_subscription_id"
        end
      end
    end

  end

end
