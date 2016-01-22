RSpec.configure do |config|
  config.before do
    FakeBraintree.clear!
  end
end
