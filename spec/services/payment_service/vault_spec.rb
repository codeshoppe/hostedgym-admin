require 'rails_helper'

describe PaymentService::Vault do
  let!(:email) { 'fake_email@tester.com' }
  let!(:first_name) { 'John' }
  let!(:last_name) { 'Smith' }

  describe '.store_customer' do
    context 'on success' do
      let(:fake_customer) do
        OpenStruct.new(
          success?: true,
          customer: OpenStruct.new(id: 'response_customer_id')
        )
      end
      it 'returns customer id' do
        customer_id = described_class.store_customer(email, first_name, last_name)
        expect(customer_id).not_to be_nil
      end

      it 'returns customer.id' do
        expect(Braintree::Customer).to receive(:create) { fake_customer }
        customer_id = described_class.store_customer(email, first_name, last_name)
        expect(customer_id).to eq('response_customer_id')
      end
    end

    context 'on error' do
      it 'from braintree it raises a generic payment service error' do
        expect(Braintree::Customer).to receive(:create) { raise Braintree::BraintreeError }

        expect {
          described_class.store_customer(email, first_name, last_name)
        }.to raise_error(PaymentService::PaymentServiceError)
      end
    end
  end

  describe '.find_customer_id' do
    context 'with existing customer' do

      let(:customer_1) { OpenStruct.new(id: 'customer1id') }
      let(:customer_2) { OpenStruct.new(id: 'customer2id') }

      it 'finds no customer' do
        expect(Braintree::Customer).to receive(:search) { [] }
        expect(described_class.find_customer_id(email)).to be_nil
      end

      it 'finds 1 customer' do
        expect(Braintree::Customer).to receive(:search) { [customer_1] }
        expect(described_class.find_customer_id(email)).to eq('customer1id')
      end

      it 'finds more than 1 customer and raises an error' do
        expect(Braintree::Customer).to receive(:search) { [customer_1, customer_2] }

        expect {
          described_class.find_customer_id(email)
        }.to raise_error(PaymentService::Vault::EmailAddressNotUniqueError)
      end
    end

    context 'on error' do
      it 'from braintree it raises a generic payment service error' do
        expect(Braintree::Customer).to receive(:search) { raise Braintree::BraintreeError }

        expect {
          described_class.find_customer_id(email)
        }.to raise_error(PaymentService::PaymentServiceError)
      end
    end
  end
end
