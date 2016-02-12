FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "email_#{n}@email.com"
    end

    sequence :first_name do |n|
      "first_name_#{n}"
    end

    sequence :last_name do |n|
      "last_name_#{n}"
    end

    password 'fakepassword&*'

    confirmed_at '2012-01-01'

    factory :admin do
      admin true
    end

    factory :user_synced_to_braintree do
      association :braintree_customer, factory: :braintree_customer_synced
    end

    factory :user_invited do
      association :braintree_customer, factory: :braintree_customer_invited
    end

    factory :gym_member do
      association :braintree_customer, factory: :braintree_customer_gym_member
    end
  end
end
