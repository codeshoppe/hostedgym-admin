require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to belong_to(:braintree_customer) }

  context 'factories' do
    context 'factory :gym_member' do
      let(:user) { FactoryGirl.create(:gym_member) }

      it 'returns a user with membership' do
        expect(user).to be_gym_member
      end

      it 'returns a user who is invited' do
        expect(user).to be_invited
      end
    end

    context 'factory :user_invited' do
      let(:user) { FactoryGirl.create(:user_invited) }
      it 'returns a user with no gym membership' do
        expect(user).not_to be_gym_member
      end

      it 'returns a user with an invitation to join' do
        expect(user).to be_invited
      end
    end
  end

  context '.policy_class' do
    it 'returns correct policy class' do
      expect(described_class.policy_class).to eq(AccountPolicy)
    end
  end

  context '#gym_member?' do
    it 'returns true if user has a subscription' do
      user = FactoryGirl.build(:user)
      user.build_braintree_customer(subscription_id: 'fake subscription')
      expect(user).to be_gym_member
    end

    it 'returns false if user has does not have a subscription' do
      user = FactoryGirl.build(:user)
      user.build_braintree_customer(subscription_id: nil)
      expect(user).not_to be_gym_member
    end
  end

  context '#invited?' do
    it 'returns true if user has been invited' do
      user = FactoryGirl.build(:user)
      user.build_braintree_customer(invited_plan_id: 'fake invite')
      expect(user).to be_invited
    end

    it 'returns true if user has not been invited' do
      user = FactoryGirl.build(:user)
      user.build_braintree_customer(invited_plan_id: nil)
      expect(user).not_to be_invited
    end
  end

  context '#can_sign_up?' do
    it 'returns true if user has been invited and is not already a gym member' do
      user = FactoryGirl.build(:user)
      user.build_braintree_customer(invited_plan_id: 'fake invite', subscription_id: nil)
      expect(user).to be_can_sign_up
    end

    it 'returns false if user already has a subscription' do
      user = FactoryGirl.build(:user)
      user.build_braintree_customer(subscription_id: 'fake subscription')
      expect(user).not_to be_can_sign_up
    end

    it 'returns false if user doesn\'t have an invite' do
      user = FactoryGirl.build(:user)
      user.build_braintree_customer(invited_plan_id: nil)
      expect(user).not_to be_can_sign_up
    end
  end
end
