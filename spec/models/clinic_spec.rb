require 'rails_helper'

RSpec.describe Clinic, type: :model do
  context 'validations' do
    it { is_expected.to validate_uniqueness_of :title }
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :price }
  end
end
