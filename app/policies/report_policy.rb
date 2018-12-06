class ReportPolicy < ApplicationPolicy

  def export_student_records?
  	user.developer?
  end

  def export_employee_records?
  	user.developer?
  end

end