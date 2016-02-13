require 'rails_helper'

RSpec.describe CustomerAccount , type: :model do
  it { is_expected.to have_one(:user) }

  context '#gym_member?' do
    it 'returns true if user has a subscription' do
      customer_account = CustomerAccount.create!(subscription_id: 'fake subscription')
      expect(customer_account).to be_gym_member
    end

    it 'returns false if user has does not have a subscription' do
      customer_account = CustomerAccount.create!(subscription_id: nil)
      expect(customer_account).not_to be_gym_member
    end
  end

  context '#invited?' do
    it 'returns true if user has been invited' do
      customer_account = CustomerAccount.create!(invited_plan_id: 'fake invite')
      expect(customer_account).to be_invited
    end

    it 'returns true if user has not been invited' do
      customer_account = CustomerAccount.create!(invited_plan_id: nil)
      expect(customer_account).not_to be_invited
    end
  end

  context '#can_sign_up?' do
    it 'returns true if user has been invited and is not already a gym member' do
      customer_account = CustomerAccount.create!(invited_plan_id: 'fake invite', subscription_id: nil)
      expect(customer_account).to be_can_sign_up
    end

    it 'returns false if user already has a subscription' do
      customer_account = CustomerAccount.create!(subscription_id: 'fake subscription')
      expect(customer_account).not_to be_can_sign_up
    end

    it 'returns false if user doesn\'t have an invite' do
      customer_account = CustomerAccount.create!(invited_plan_id: nil)
      expect(customer_account).not_to be_can_sign_up
    end
  end
end
