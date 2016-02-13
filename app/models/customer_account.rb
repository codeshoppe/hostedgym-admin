class CustomerAccount < ActiveRecord::Base
  has_one :user

  def gym_member?
    subscription_id.present?
  end

  def invited?
    invited_plan_id.present?
  end

  def can_sign_up?
    !gym_member? && invited?
  end
end
