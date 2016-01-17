class ContactMessage
  include ActiveModel::Model

  attr_accessor :name, :email, :subject, :message

  validates :name, presence: true
  validates :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :subject, presence: true
  validates :message, presence: true
end
