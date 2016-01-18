class ContactMessagesController < ApplicationController
  def create
    @contact_message = ContactMessage.new(params[:contact_message])
    if @contact_message.valid?
      if @contact_message.deliver!
        render json: { message: 'contact message sent' }
      else
        render status: :service_unavailable, json: { message: 'sendgrid unavailable' }
      end
    else
      render status: :bad_request, json: { errors: @contact_message.errors.full_messages }
    end
  end
end
