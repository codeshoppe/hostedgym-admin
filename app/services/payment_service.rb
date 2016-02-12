module PaymentService

  class PaymentServiceError < ::StandardError; end

  class Base
    def self.safely_call(&block)
      begin
        yield
      rescue Braintree::BraintreeError => error
        Rails.logger.error("BraintreeError: #{error.message}\n#{error.backtrace}")
        raise PaymentServiceError, error.class.name.demodulize
      end
    end
  end

end
