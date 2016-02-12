require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  context '#application_title' do
    it 'returns a default' do
      expect(ENV).to receive(:[]).with('APPLICATION_TITLE') { nil }
      expect(helper.application_title).to eq('HostedGym')
    end

    it 'returns a the set env var' do
      expect(ENV).to receive(:[]).with('APPLICATION_TITLE') { 'fake title' }
      expect(helper.application_title).to eq('fake title')
    end
  end
end
