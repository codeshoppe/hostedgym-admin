Braintree::Configuration.environment = ENV['BRAINTREE_ENVIRONMENT'] if ENV['BRAINTREE_ENVIRONMENT'].present?
Braintree::Configuration.merchant_id = ENV['BRAINTREE_MERCHANT_ID'] if ENV['BRAINTREE_MERCHANT_ID'].present?
Braintree::Configuration.public_key  = ENV['BRAINTREE_PUBLIC_KEY']  if ENV['BRAINTREE_PUBLIC_KEY'].present?
Braintree::Configuration.private_key = ENV['BRAINTREE_PRIVATE_KEY'] if ENV['BRAINTREE_PRIVATE_KEY'].present?
