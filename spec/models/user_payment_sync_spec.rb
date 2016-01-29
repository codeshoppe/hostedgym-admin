require 'rails_helper'

describe UserPaymentSync do
  context '#sync_customer!' do
    let(:user) { FactoryGirl.create(:user) }
    subject { UserPaymentSync.new(user) }

    it 'creates a braintree customer for user' do
      expect(PaymentService::Vault).to receive(:find_customer_id) { 'fake_customer_id' }
      subject.sync_customer!
      expect(user.braintree_customer).to be_persisted
      expect(user.braintree_customer.customer_id).to eq('fake_customer_id')
    end

    it 'doesn\'t check the vault if the user already has a customer_id' do
      user.create_braintree_customer!(customer_id: 'existing_customer_id')

      expect(PaymentService::Vault).not_to receive(:find_customer_id)
      subject.sync_customer!
      expect(user.braintree_customer.customer_id).to eq('existing_customer_id')
    end

    it 'updates the braintree customer if the customer exists in vault' do
      user.create_braintree_customer!

      expect(PaymentService::Vault).to receive(:find_customer_id) { 'fake_customer_id' }
      subject.sync_customer!
      expect(user.braintree_customer.customer_id).to eq('fake_customer_id')
    end

    it 'stores the customer if the user isn\'t in the vault' do
      user.create_braintree_customer!

      expect(PaymentService::Vault).to receive(:find_customer_id) { nil }
      expect(PaymentService::Vault).to receive(:store_customer) { 'new_customer_id' }
      subject.sync_customer!
      expect(user.braintree_customer.customer_id).to eq('new_customer_id')
    end
  end
end
