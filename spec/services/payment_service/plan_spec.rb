require 'rails_helper'

describe PaymentService::Plan do
  context '.all' do
    it 'returns a list of Plan objects' do
      expect(Braintree::Plan).to receive(:all) { 5.times.map { OpenStruct.new } }
      expect(described_class.all).to all( be_kind_of(Plan) )
    end
  end
end
