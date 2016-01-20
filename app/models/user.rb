class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :confirmable

  validates_presence_of :first_name, :last_name

  belongs_to :braintree_customer

  scope :admins, -> { where(admin: true) }
  scope :accounts, -> { where(admin: false) }

  after_create :sync_to_payment_service

  def self.policy_class
    AccountPolicy
  end

  def gym_member?
    braintree_customer.subscription_id.present?
  end

  def invited?
    braintree_customer.invited_plan_id.present?
  end

  def can_sign_up?
    !gym_member? && invited?
  end

  private
  def sync_to_payment_service
    customer_id = PaymentService::Vault.store_customer(self.email, self.first_name, self.last_name)
    if customer_id.present?
      self.create_braintree_customer!(customer_id: customer_id) 
    else
      raise Exception, 'Could not sync user to payment service'
    end
  end
end
