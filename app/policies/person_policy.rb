class PersonPolicy < ApplicationPolicy
    def index?
      true
    end

    class Scope
      attr_reader :user, :scope
      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        if user.admin?
          scope.all
        else
          scope.where(user: user)
        end
      end
    end

    def create?
      user.present?
    end

    def show?
      return true if user.admin? or record.try(:user) == user 
    end

    def update?
      return true if  user.admin? or record.try(:user) == user 
    end

    def destroy? 
      user.admin? or record.try(:user) == user
    end

    private

    def person
      record
    end
end
