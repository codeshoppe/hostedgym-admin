require 'rails_helper'

RSpec.describe CustomerAccount , type: :model do
  it { is_expected.to have_one(:user) }
end
