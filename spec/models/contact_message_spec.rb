require 'rails_helper'

RSpec.describe ContactMessage, type: :model do
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_presence_of(:email) }
  it { expect(subject).to validate_presence_of(:subject) }
  it { expect(subject).to validate_presence_of(:message) }

  it { expect(subject).to allow_value("test@codeshoppe.io").for(:email) }
  it { expect(subject).to_not allow_value("fail").for(:email) }
end
