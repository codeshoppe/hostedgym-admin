FactoryGirl.define do
  factory :customer_account do

    factory :customer_account_synced do
      customer_id "existing_customer_id"

      factory :customer_account_invited do
        invited_plan_id "fake_plan_id"

        factory :customer_account_gym_member do
          subscription_id "existing_subscription_id"
        end
      end
    end

  end

end
