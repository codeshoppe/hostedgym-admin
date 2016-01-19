class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :confirmable

  validates_presence_of :first_name, :last_name

  has_one :braintree_customer

  def sync_to_payment_service
    customer_id = PaymentService::Vault.store_customer(self.email, self.first_name, self.last_name)
    if customer_id.present?
      self.create_braintree_customer!(customer_id: customer_id) 
    else
      raise Exception, 'Could not sync user to payment service'
    end
  end
end
