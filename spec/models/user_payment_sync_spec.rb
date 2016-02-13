require 'rails_helper'

describe UserPaymentSync do
  context '#sync_customer!' do
    let(:user) { FactoryGirl.create(:user) }
    subject { UserPaymentSync.new(user) }

    it 'creates a braintree customer for user' do
      expect(PaymentService::Vault).to receive(:find_customer_id) { 'fake_customer_id' }
      subject.sync_customer!
      expect(user.customer_account).to be_persisted
      expect(user.customer_account.customer_id).to eq('fake_customer_id')
    end

    it 'doesn\'t check the vault if the user already has a customer_id' do
      user.create_customer_account!(customer_id: 'existing_customer_id')

      expect(PaymentService::Vault).not_to receive(:find_customer_id)
      subject.sync_customer!
      expect(user.customer_account.customer_id).to eq('existing_customer_id')
    end

    it 'updates the customer account if the customer exists in vault' do
      user.create_customer_account!

      expect(PaymentService::Vault).to receive(:find_customer_id) { 'fake_customer_id' }
      subject.sync_customer!
      expect(user.customer_account.customer_id).to eq('fake_customer_id')
    end

    it 'stores the customer if the user isn\'t in the vault' do
      user.create_customer_account!

      expect(PaymentService::Vault).to receive(:find_customer_id) { nil }
      expect(PaymentService::Vault).to receive(:store_customer) { 'new_customer_id' }
      subject.sync_customer!
      expect(user.customer_account.customer_id).to eq('new_customer_id')
    end
  end

  context '#create_subscription!' do
    let(:fake_payment) { double(:payment) }

    context 'when user is already a member' do
      let(:user) { FactoryGirl.create(:gym_member) }

      it 'will not create a subscription if user already has a subscription' do
        syncer = UserPaymentSync.new(user)
        expect(PaymentService::Subscription).not_to receive(:create)
        syncer.create_subscription!(fake_payment)
      end
    end

    context 'when user is not a member' do

      context 'when a user is invited' do
        let(:user) { FactoryGirl.create(:user_invited) }
        let(:fake_subscription) {
          OpenStruct.new(
            subscription: OpenStruct.new(id: 'new_subscription_id')
          )
        }

        it 'will not create a subscription if user becomes invited before completion' do
          expect(user.customer_account.subscription_id).to be_blank

          syncer = UserPaymentSync.new(user)
          user.customer_account.update_column(:subscription_id, 'fake_subscription_id')

          expect(PaymentService::Subscription).not_to receive(:create)
          syncer.create_subscription!(fake_payment)
        end

        it 'will create a subscription' do
          expect(user.customer_account.subscription_id).to be_blank

          syncer = UserPaymentSync.new(user)

          expect(PaymentService::Subscription).to receive(:create) { fake_subscription }
          syncer.create_subscription!(fake_payment)
          user.reload
          user.customer_account.subscription_id = 'new_subscription_id'
        end

      end

      context 'when a user is not invited' do
        let(:user) { FactoryGirl.create(:user_synced_to_payment_service) }

        it 'will raise NoInvitation error if user is not invited' do
          syncer = UserPaymentSync.new(user)
          expect {
            syncer.create_subscription!(fake_payment)
          }.to raise_error(UserPaymentSync::NoInvitation)
        end
      end
    end


  end
end
