class ServiceRequestPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      elsif user.department_user?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end

  def create?
    user.citizen?
  end

  # def update?
  #   user.admin? || (user.department_user? && record.category == user.department_category)
  # end
  def update?
    user.admin? || user.citizen? || user.department_user
  end

  def destroy?
    user.admin?
  end

  def show?
    user.admin? || user.department_user? || record.user == user
  end
end