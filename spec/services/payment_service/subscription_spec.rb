require 'rails_helper'

describe PaymentService::Subscription do
  let(:braintree_subscription) { instance_double(Braintree::Subscription) }
  let(:fake_subscription) { instance_double(Subscription) }

  describe '.create' do
    it 'adds a subscription to braintree' do
      subscription = described_class.create(:payment_method, 'fake plan id')
      expect(Braintree::Subscription.find(subscription.id)).not_to be_blank
    end

    it 'returns a Subscription' do
      args = {payment_method_nonce: 'nonce', plan_id: 'plan_id'}
      expect(BraintreeSubscriptionAdapter).to receive(:adapt).with(braintree_subscription) { fake_subscription }
      expect(Braintree::Subscription).to receive(:create).with(args) { OpenStruct.new(success?: true, subscription: braintree_subscription) }
      result = described_class.create('nonce', 'plan_id')
      expect(result).to eq(fake_subscription)
    end

    it 'raises a generic payment service error if braintree fails' do
      expect(Braintree::Subscription).to receive(:create) { raise Braintree::BraintreeError }

      expect {
        described_class.create('nonce', 'plan_id')
      }.to raise_error(PaymentService::PaymentServiceError)
    end
  end

  describe '.find' do
    let!(:payment_methods) do
      [
        OpenStruct.new(subscriptions: [OpenStruct.new(id: 'sub1')]),
        OpenStruct.new(subscriptions: [OpenStruct.new(id: 'sub2')])
      ]
    end
    let!(:customer) { OpenStruct.new(payment_methods: payment_methods) }


    it 'returns subscription if it can find it' do
      expect(Braintree::Customer).to receive(:find) { customer }

      result = described_class.find('customer_id', 'sub2')
      expect(result).to be_kind_of(Subscription)
    end

    it 'returns nil if it can\'t find it' do
      expect(Braintree::Customer).to receive(:find) { customer }

      result = described_class.find('customer_id', 'sub3')
      expect(result).to be_nil
    end
  end
end
