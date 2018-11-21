class StudentRecordPolicy < ApplicationPolicy

  def delete_all?
  	user.admin? || user.developer?
  end

end