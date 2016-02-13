class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :confirmable

  validates_presence_of :first_name, :last_name

  belongs_to :customer_account

  scope :admins, -> { where(admin: true) }
  scope :customers, -> { where(admin: false) }

  delegate :gym_member?, :invited?, :can_sign_up?, to: :customer_account, allow_nil: false

  def self.policy_class
    AccountPolicy
  end

end
