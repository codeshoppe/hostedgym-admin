require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:posted_on) }
  it { should validate_presence_of(:body) }
end
