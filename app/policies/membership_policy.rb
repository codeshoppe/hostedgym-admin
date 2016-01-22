class MembershipPolicy < Struct.new(:user, :membership)
  def new?
    !user.gym_member?
  end

  def create?
    user.can_sign_up?
  end
end
