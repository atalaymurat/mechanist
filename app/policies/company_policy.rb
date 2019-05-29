class CompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end

  end

  def index?
  end

  def create?
    user.present?
  end

  def show?
    return true if user.admin? or record.try(:user) == user
  end

  def update?
    return true if user.admin? or record.try(:user) == user
  end

  def destroy?
    user.admin? or record.try(:user) == user
  end

  private
  
  def company
    record
  end

end
