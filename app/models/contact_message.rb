require 'sendgrid-ruby'

class ContactMessage
  include ActiveModel::Model

  attr_accessor :name, :email, :subject, :message

  validates :name, presence: true
  validates :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :subject, presence: true
  validates :message, presence: true

  def deliver!
    client = SendGrid::Client.new(api_key: ENV['sendgrid_api_key'])
    mail = SendGrid::Mail.new(
      to: email,
      from: ENV['CONTACT_MESSAGE_RECIPIENT'],
      subject: subject,
      text: message
    )
    res = client.send(mail)
    /2\d\d/.match(res.code)
  end
end
