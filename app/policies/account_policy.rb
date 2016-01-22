class AccountPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def update?
    user.admin?
  end

  class Scope < Scope
    def resolve
      user.admin? ? scope.accounts : scope.none
    end
  end

end
