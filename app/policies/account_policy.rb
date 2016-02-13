class AccountPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def update?
    user.admin?
  end

  class Scope < Scope
    def resolve
      user.admin? ? scope.customers : scope.none
    end
  end

end
