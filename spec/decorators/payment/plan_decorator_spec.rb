require 'rails_helper'

describe Payment::PlanDecorator do

  let(:plan_1_month) { PaymentService::Plan.new(id: '456', price: BigDecimal.new("56.78"), billing_frequency: 1) }
  let(:plan_2_month) { PaymentService::Plan.new(id: '456', price: BigDecimal.new("56.78"), billing_frequency: 2) }

  context '#collection_label_method' do

    it 'returns descriptive text for the label for billing frequency of 1 month' do
      decorator = described_class.new(plan_1_month)
      expect(decorator.collection_label_method).to eq('456 - $56.78 every 1 month')
    end

    it 'returns descriptive text for the label for billing frequency of 2 months' do
      decorator = described_class.new(plan_2_month)
      expect(decorator.collection_label_method).to eq('456 - $56.78 every 2 months')
    end

  end

  context '#collection_value_method' do
    subject { described_class.new(plan_1_month) }

    it 'returns id for the value' do
      expect(subject.collection_value_method).to eq('456')
    end
  end
end
