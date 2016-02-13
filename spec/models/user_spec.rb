require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to belong_to(:customer_account) }

  it { is_expceted.to delegate_method(:gym_member?).to(:customer_account) }
  it { is_expceted.to delegate_method(:invited?).to(:customer_account) }
  it { is_expceted.to delegate_method(:can_sign_up?).to(:customer_account) }

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

end
