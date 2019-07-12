class UserPolicy < ApplicationPolicy
  class Scope < Scope

    def resolve
      if user.admin?
        scope.all
      else
        scope.where(admin: false)
      end
    end
  end

  def show?
    return true if record.id == user.id or user.admin?
  end

  def index?
    true
  end

  def update?
    if user.admin?
      case record.admin?
      when user.id == 1
        return true
      when record.id == user.id
        return true
      else
        return false
      end
    elsif
      record.id == user.id
      return true
    else
      return false
    end
  end

  def destroy?
    if user.admin?
      unless record.admin?
        return true #any admin can do user acc.
      end
      case record.admin?
      when user.id == 1 #master admin can do all acc.
        return true
      when record.id == user.id #admin can do own admin acc.
        return true
      else
        return false #users can not do any acc.
      end
    else
      return false
    end
  end
end
