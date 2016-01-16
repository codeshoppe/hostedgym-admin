FactoryGirl.define do
  factory :post do
    title "Title 1"
    posted_on 1.years.ago
    body "This is the body"
  end
end
