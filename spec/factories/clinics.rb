FactoryGirl.define do
  factory :clinic do
    title "Fake Clinic"
    description "Fake Description"
    spots_available 10
    price 9.99
    scheduled_for "2016-01-25 21:14:02"
    open_for_registration false
  end
end
