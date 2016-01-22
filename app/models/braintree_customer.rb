class BraintreeCustomer < ActiveRecord::Base
  has_one :user
end
