class EmployeePolicy < ApplicationPolicy

  def new?
    user.admin? || user.developer?
  end

  def create?
    new?
  end

  def edit?
    user.admin? || user.developer?
  end 

  def update?
    edit?
  end
end