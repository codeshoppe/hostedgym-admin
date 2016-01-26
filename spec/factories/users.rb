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

    factory :user_with_braintree_customer do
      association :braintree_customer, strategy: :build
    end
  end
end
