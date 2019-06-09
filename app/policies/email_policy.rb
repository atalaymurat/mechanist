class EmailPolicy < ApplicationPolicy
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


  private
  
  def email
    record
  end

end
