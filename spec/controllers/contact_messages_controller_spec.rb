require 'rails_helper'

RSpec.describe ContactMessagesController, type: :controller do
  let(:contact_message_attrs) { FactoryGirl.attributes_for(:contact_message) }

  describe 'POST #create' do
    it 'responds with a bad request' do
      post :create, contact_message: {}
      expect(response).to have_http_status(:bad_request)
    end

    it 'responds with a successful request' do
      sendgrid_response = instance_double('SendGrid::Response', code: '200')
      allow_any_instance_of(SendGrid::Client).to receive(:send).and_return(sendgrid_response)

      post :create, contact_message: contact_message_attrs
      expect(response).to be_successful
    end

    it 'responds when sendgrid is unavailable' do
      allow_any_instance_of(ContactMessage).to receive(:deliver!).and_return(false)

      post :create, contact_message: contact_message_attrs
      expect(response).to have_http_status(:service_unavailable)
    end
  end
end
