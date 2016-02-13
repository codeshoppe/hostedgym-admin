require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do

  context 'assuming user is already synced to braintree' do
    before do
      allow_any_instance_of(described_class).to receive(:sync_user_to_payment_service) { nil }
    end

    context 'GET new' do
      context 'when user is already a member' do
        login_user(:gym_member)

        it 'redirects to membership path' do
          get :new
          expect(response).to redirect_to(membership_path)
        end
      end

      context 'when user is not a member' do
        login_user(:user_synced_to_payment_service)

        it 'responds with success' do
          get :new
          expect(response).to be_success
        end

        it 'responds sets the client token' do
          expect(Braintree::ClientToken).to receive(:generate).with({customer_id: 'existing_customer_id'}) { 'fake_token' }
          get :new
          expect(assigns(:client_token)).to eq('fake_token')
        end
      end
    end

    context 'GET show' do
      context 'when user is already a member' do
        login_user(:gym_member)

        it 'assigns @subscription' do
          expect(PaymentService::Subscription).to receive(:find).with('existing_customer_id', 'existing_subscription_id') { :subscription_from_payment_service }
          get :show
          expect(assigns(:subscription)).to eq(:subscription_from_payment_service)
        end
      end

      context 'when user is not a member' do
        login_user(:user_synced_to_payment_service)

        it 'assigns @subscription' do
          expect(PaymentService::Subscription).not_to receive(:find)
          get :show
          expect(assigns(:subscription)).to eq(nil)
        end
      end
    end

    context 'POST create' do
      context 'when user is already a member' do
        login_user(:gym_member)

        it 'create is not allowed' do
          post :create
          expect(response).to redirect_to('/')
          expect(flash[:alert]).to eq("You are not authorized to perform this action.")
        end
      end

      context 'when user is not invited' do
        login_user(:user_synced_to_payment_service)

        it 'create is not allowed' do
          post :create
          expect(response).to redirect_to('/')
          expect(flash[:alert]).to eq("You are not authorized to perform this action.")
        end
      end

      context 'when user is can sign up' do
        login_user(:user_invited)

        it 'requires payment_method_nonce to be sent over' do
          expect {
            post :create
          }.to raise_error(Exception)
          expect(flash[:error]).to eq("Invalid payment method.")
        end

        it 'redirects when creating a subscription is successful' do
          expect_any_instance_of(UserPaymentSync).to receive(:create_subscription!).with('fake nonce') { true }
          post :create, payment_method_nonce: 'fake nonce'
          expect(response).to redirect_to(membership_path)
          expect(flash[:notice]).to eq("Success!")
        end

        it 'displays error message when subscription create fails' do
          expect_any_instance_of(UserPaymentSync).to receive(:create_subscription!).with('fake nonce') { false }
          post :create, payment_method_nonce: 'fake nonce'
          expect(flash[:error]).to eq('Could not create subscription, please contact the admin.')
        end
      end
    end
  end

end
