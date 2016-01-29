require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do

  login_user

  context 'GET new' do
    context 'when user is already a member' do
      before :each do
        expect(PaymentService::Vault).to receive(:find_customer_id) { 'fake_customer_id' }
        signed_in_user.create_braintree_customer!(subscription_id: 'fake_subscription')
      end

      it 'redirects to membership path' do
        get :new
        expect(response).to redirect_to(membership_path)
      end
    end

    context 'when user is not a member' do
      before :each do
        expect(PaymentService::Vault).to receive(:find_customer_id) { 'fake_customer_id' }
        signed_in_user.create_braintree_customer!(subscription_id: nil)
      end

      it 'responds with success' do
        get :new
        expect(response).to be_success
      end

      it 'responds sets the client token' do
        expect(Braintree::ClientToken).to receive(:generate).with({customer_id: 'fake_customer_id'}) { 'fake_token' }
        get :new
        expect(assigns(:client_token)).to eq('fake_token')
      end
    end

  end

end
